select sum(nota * cred) / sum(cred) from cursadas, disciplinas where cursadas.cod_disc = disciplinas.cod_disc group by ra;

