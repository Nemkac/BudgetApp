const CategoryType = {
  Expense: 'Expense',
  Income: 'Income',
};

function getInitialCategories() {
  return [
    {
      name: 'Groceries',
      color: '#FF3131',
      icon: 'shopping-cart',
      type: CategoryType.Expense,
      favorite: false,
    },
    {
      name: 'Salary',
      color: '#00B2FF',
      icon: 'wallet',
      type: CategoryType.Income,
      favorite: false,
    },
    {
      name: 'Rent',
      color: '#C9FF31',
      icon: 'home',
      type: CategoryType.Expense,
      favorite: false,
    },
    {
      name: 'Utilities',
      color: '#20F5CF',
      icon: 'sliders-v',
      type: CategoryType.Expense,
      favorite: false,
    },
    {
      name: 'Freelance Income',
      color: '#C89CFF',
      icon: 'user',
      type: CategoryType.Income,
      favorite: false,
    },
  ];
}

module.exports = {
  getInitialCategories,
};
