program gaussN;
type table = array[1..20,1..20]of real;
var mat, L, U, L1, U1: table;
var a,b,i,j,MAX: integer;

procedure display(M: table);
begin
	for a:=1 to MAX do
        begin
            for b:=1 to MAX do
            write(M[a][b]:4:2,'  ');
            writeln;
        end;
end;

begin
	writeln('Entrez la taille de la matrice.(Entre 2 et 20)');
	readln(MAX);
	writeln('Entrez les valeurs de la matrice (Separez chaque numéro avec un ESPACE et utilisez ENTREE pour changer les lignes.)');
	for a:=1 to MAX do
		begin
			for b:=1 to MAX do
				begin
					read(mat[a,b]);
					write('  ');
				end;
			writeln;
		end;
		
		
	for a:=1 to MAX do
		L1[a,a]:=1;
		U1[a][a]:=0;
	for b:=2 to MAX do
		L1[b][1]:=-mat[b][1]/mat[1][1];
    for a:=1 to MAX do
		begin
			for b:=1 to MAX do
				begin
					for i:=1 to MAX do
					begin
					U1[a][1]:=U1[a][1]+L1[a][i]*mat[i][b];
					U1[a][b]:=U1[a][b]+L1[a][i]*mat[i][b]
					end;
				end;
		end;
	writeln('L1');
	display(L1);
	writeln('U1');
	display(U1);
		
		
    for a:=1 to MAX do
		L[a,a]:=1;
    for a:=1 to MAX-1 do
		begin
			for b:=a+1 to MAX do
				begin
					L[a,b]:=0;
					L[b,a]:=mat[b,a]/mat[a,a];
					U[a,b-1]:=mat[a,b-1];
					U[b,a]:=0;
				end;
			U[a,MAX]:=mat[a,MAX];					
			for i:=a+1 to MAX do
				begin
					for j:=a+1 to MAX do
						mat[i,j]:=-L[i,a]*mat[a,j]+mat[i,j];
				end;	
		end;
	U[MAX,MAX]:=mat[MAX,MAX];
	writeln('L');
	display(L);
	writeln('U');
	display(U);
	
end.
