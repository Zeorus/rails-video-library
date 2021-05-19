import swal from 'sweetalert';

const alertDeleteList = () => {
  if (document.querySelector('.delete-list-btn')) {
    const deleteListBtn = document.querySelectorAll('.delete-list-btn');
    deleteListBtn.forEach((btn) => {
      btn.addEventListener('click', (event) => {
        const listID = event.currentTarget.dataset.removeBtnListId;
        swal({
          title: "Attention",
          text: "Êtes-vous sûr de vouloir supprimer cette liste ? Tous les films qui en font parti seront retirés.",
          icon: "warning",
          closeOnClickOutside: false,
          closeOnEsc: false,
          dangerMode: true,
          buttons: ["Annuler", "Confirmer"]
        }).then((value) => {
          if (value) {
            const link = document.getElementById(`remove-link-list-id-${listID}`);
            link.click();
          }
        })
      });
    });
  }
}

export { alertDeleteList };
