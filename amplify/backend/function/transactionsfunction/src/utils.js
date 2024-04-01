const levenshtein = require('fast-levenshtein');

/**
 * Predicts the category for a new transaction based on a merchant name extracted via OCR,
 * comparing it against previous transactions to find the most similar merchant name.
 *
 * The function calculates the Levenshtein distance between the OCR-extracted merchant name
 * and merchant names in existing transactions. It then converts this distance into a similarity
 * score to identify the most similar merchant. The category of the transaction with the most similar
 * merchant name is suggested for the new transaction.
 *
 * @param transactions An array of previous transactions.
 * @param merchantNameFromOCR The merchant name extracted from the receipt via OCR.
 * @returns A prediction object containing the suggested category and confidence level, or null if no similar merchant is found.
 */
function predictCategory(transactions, merchantNameFromOCR) {
  let mostSimilarTransaction;
  let highestSimilarity = 0;

  transactions.forEach((transaction) => {
    const distance = levenshtein.get(
      merchantNameFromOCR.toLowerCase(),
      transaction?.merchantName?.toLowerCase()
    );
    const similarity =
      1 -
      distance /
        Math.max(merchantNameFromOCR.length, transaction?.merchantName?.length);
    if (similarity > highestSimilarity) {
      highestSimilarity = similarity;
      mostSimilarTransaction = transaction;
    }
  });

  const similarityThreshold = 0.7;
  if (mostSimilarTransaction && highestSimilarity >= similarityThreshold) {
    return {
      categoryId: mostSimilarTransaction.categoryId,
      confidence: highestSimilarity,
    };
  }

  return null;
}

module.exports = {
  predictCategory,
};
