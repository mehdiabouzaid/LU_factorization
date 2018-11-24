program Eliminationdegauss;

{ -----------Ce programme résout un système linéaire du type AX=B avec une matrice carrée A de taille n -------------}


{------ on commence par définir la taille maximale de la matrice A, ici 20 par 20, et donc on défnit la taille ------
 -------------------------------- du vecteur B qui est tout logiquement 20-------------------------------------------}
type
	matrice = array [1..20, 1..20] of real;
	vecteur = array [1..20] of real;
var
	A: matrice;
	B, X: vecteur; 
	n,i,j,k,l: integer;
	Epsilon, m, s: real;
	Singularite: boolean;
	
procedure Echanger(var x,y: real);
{-----------------Procédure qui échange tout simplement les valeurs des variables X et Y--------------------}
	var
		t: real;
	begin
		t:=x;
		x:=y;
		
		y:=t;
	end;

procedure EcrireSystemeDequations; 
{-----Procédure qui affiche dans le terminal le système d'équations définit par A ainsi que le système------
 -----d'équations définit par U, la matrice triangulaire. Les chiffres significatifs n'ont ici aucune-------
 ----------------------------------importance, on en affiche que 3------------------------------------------}
	var
		i,j: integer;
	begin
		for i:=1 to n do
		begin
			write('     ',A[i,1]:1:3,' x',1:1,' ');
			for j:=2 to n do
			begin
				if A[i,j]>=0.0 then
					write('+');
				write(A[i,j]:1:3,' x',j:1,' ');
			end;
			writeln('= ',B[i]:1:3);
		end;
	end; 
	
begin { ------------------Programme principale correspondant à l'EliminationDeGauss------------------------- }
	writeln('Resolution d''un systeme AX=B');
	writeln('par la	methode d''elimination de Gauss');
	writeln('Taille de la matrice A: n');
	writeln;
	
	{-----on demande à l'utilisateur du programme de rentrer la taille n de la matrice, puis de rentrer -----
	 ---------les différents coefficients de chaque équation ainsi que le résultat de chaque équation--------
	 --------------------------On remplit ainsi la matrice A et le vecteur B---------------------------------}
	write('Donner n (<20) =');
	readln(n);
	writeln;
	writeln('  Donner A:');
	for i:=1 to n do
		for j:=1 to n do
			begin
				write('    A[',i,',',j,'] =');
				readln(A[i,j]);
			end;
	writeln;
	writeln('  donner B');
	for i:=1 to n do
	begin
		write('    B[',i,'] = ');
		readln(B[i]);
	end;
	
	{-----------------On initialise le vecteur X correspondant au vecteur que l'on recherche----------------}
	for i:=1 to n do
		X[i]:=0;
	
	{--------On écrit dans le terminal l'ensemble du système d'équations définit par A, pour cela on--------
	 -----------------------lance une autre prodédure nommée EcrireSystemeDequations------------------------}	
	writeln;
	writeln('Systeme d''equation:');
	EcrireSystemeDequations;
	
	{--------On arrive maintenant dans la phase d'élimination qui va nous permettre de déterminer la--------
	 --------matrice U ainsi que le nouveau vecteur B. Cette étape est en fait très optimisée car on--------
	 ------va déterminer U et le nouveau B sans avoir à déterminer la matrice triangulaire inférieure-------
	 ----------L ni son inverse L-¹. On évite ainsi plein d'erreurs de calcul et on a une meilleure---------
	 --------précision. Cette phase d'élimination comporte plusieurs étapes: la recherche de l'indice-------
	 --------l du pivot, l'échange des équations si nécessaire, et enfin le calcul de U et du nouveau-------
	 -----------------------vecteur B. Toutes ces étapes sont expliquées ci-dessous.------------------------}
	k:=1;
	Epsilon:=1E-50;
	singularite := false;
	while (k<=n) and (not singularite) do
	begin
	{-------L'étape qui suit concerne la recherche de l'indice l du pivot. Pour chaque colonne, on va-------
	 -------vérifier quel est le terme dont la valeur absolue est la plus importante. Pour la colonne-------
	 ------1 on vérifie sur les n lignes, pour la colonne 2 sur les n-1 lignes (on enlève la première)------
	 -----etc jusqu'à la colonne n où l'on ne vérifie que la dernière ligne. On commence par la colonne-----
	 ------1 et on finie par la nième. Notons que la recherche du pivot ne se fait que sur les valeurs------
	 ------d'une colonne donnée et non sur les valeurs de la ligne, et donc on parle de pivot partiel-------
	 -----et non de pivot total. L'indice l du pivot va prendre des valeurs allant de 1 à n. Remarquons-----
	 -------que c'est aussi dans cette étape que l'on vérifie si les pivots sont nuls. Mais comme on-------- 
	 ------utilise des flottants et non des réels, on utilise des approximations et on va donc comparer-----
	 --------------------------les pivots à une valeur très proche de 0: Epsilon.---------------------------}
		l:=k;
		for i:=k+1 to n do
			if abs(A[i,k]) > abs(A[l,k]) then
				l:=i;
			if (abs(A[l,k]) <= Epsilon) then
				singularite := true
			else
				if l<>k then
				begin
					{--Maintenant que l'on a l'indice l du pivot dont la valeur absolue est la plus élevée-- 
					 --on va pouvoir échanger les équations d'indice k et l. On le fait seulement dans le---
					 --cas où k et l sont différents. On met ainsi le pivot maximal en haut de colonne, on--
					 -obtient finalement une matrice avec les pivots maximals dans la diagonale descendante-}
					for j:=k to n do
						Echanger(A[k,j],A[l,j]);
						Echanger(B[k],B[l]);
				end;
		{---On arrive finalement dans l'étape dite d'élimination où l'on calcule U et le nouveau vecteur----
		 ---B. Cette étape ne peut avoir lieu que si les pivots sont non nuls. Cette étape repose en fait---
		 ---sur un simple calcul, que ce soit pour U ou pour le nouveau vecteur B. Voir calcul ci-dessous---}
		if not singularite then
			for i:= k+1 to n do
			begin
				m:=A[i,k]/A[k,k];
				for j:=k+1 to n do
					A[i,j] := A[i,j]-(m*A[k,j]);
				A[i,k]:=0.0;
				B[i]:=B[i]-(m*B[k]);
			end;
		k:=k+1;
	end;
	
	{--------On écrit dans le terminal l'ensemble du système d'équations définit par U, pour cela on--------
	 -----------------------lance une autre prodédure nommée EcrireSystemeDequations------------------------}
	writeln;
	writeln('Systeme d''equations apres la phase d''elimination:');
	EcrireSystemeDequations;
	writeln;
	
	{-----On arrive désormais à la phase de substitution. On a la matrice U, on vérifie alors que tous------
	 -----les pivots sont non nuls. S'ils ne le sont pas, on ne peut pas appliquer ce programme, et on------
	 -------l'annonce à l'utilisateur. S'ils le sont, on applique la phase remontante de substitution-------}
	if singularite then
		writeln('Un pivot est nul')
	else
	begin
		{-----On applique la phase remontante de substitution: on a la matrice triangulaire U, on peut------
		 -----donc remonter de la dernière équation (qui n'a qu'une seule inconnue) jusqu'à le première-----
		 -----------(qui a toutes les inconnues). On détermine ainsi le vecteur X que l'on cherche----------}
		for i:=n downto 1 do
		begin
			s:=B[i];
			for j:=i+1 to n do
				s:=s-A[i,j]*X[j];
			X[i]:=s/A[i,i];
		end;
		
		{-----On affiche finalement la solution cherchée, soit le vecteur X. Ici on affiche 15 chiffres-----
		 -----------------------significatifs. Cela permet d'avoir une précision maximale-------------------}
		writeln('Solution X:');
		for i:=1 to n do
		begin
			write(X[i]:15:15);
			writeln;
		end;
		readln;
	end;
	
end.
