var modal = document.querySelector(".modal_body");
var modal_act = document.querySelector(".modal_active");
var log_mod = document.querySelector(".sign_modal");


var pop_close = document.querySelectorAll(".close_pop");
for (var i = 0; i < pop_close.length; i++) {
    pop_close[i].addEventListener("click", function () { modal.style.display = "none"; });
}


window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

function modal_log() {
    modal_act.style.display = "none"; 
    log_mod.style.display = "block";
    pop_close = document.querySelector(".close_pop");
}


if (typeof document.querySelector(".sign_in") !== 'undefined' || document.querySelector(".sign_in") == null) {
    var log = document.querySelector(".sign_in").addEventListener("click", function () {
        modal.style.display = "block";
        if (modal_act.style.display != "block") {
            modal_act.style.display = "block";
        }
        if (log_mod.style.display != "none") {
            log_mod.style.display = "none";
        }

    });
}