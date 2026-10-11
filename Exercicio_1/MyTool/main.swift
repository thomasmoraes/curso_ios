import Foundation

// MARK: - Protocol

protocol Documento {
var id: Int { get }
func exibirDetalhes()
}

// MARK: - Classe Livro

class Livro: Documento {
    
let id: Int
    
private(set) var titulo: String
private(set) var autor: String
private(set) var anoPublicacao: Int
private(set) var isEmprestado: Bool
    
init(
id: Int,
titulo: String,
autor: String,
anoPublicacao: Int
) {
self.id = id
self.titulo = titulo
self.autor = autor
self.anoPublicacao = anoPublicacao
self.isEmprestado = false
}
    
func emprestar() {
if isEmprestado {
print("Livro já está emprestado.")
} else {
isEmprestado = true
print("Livro emprestado com sucesso.")
}
}
    
func devolver() {
if !isEmprestado {
print("Livro já está disponível.")
} else {
isEmprestado = false
print("Livro devolvido com sucesso.")
}
}
    
func atualizarDados(
titulo: String,
autor: String,
anoPublicacao: Int
) {
self.titulo = titulo
self.autor = autor
self.anoPublicacao = anoPublicacao
}
    
func exibirDetalhes() {
    
let status = isEmprestado
? "Emprestado"
: "Disponível"
    
print("""
-----------------------------
ID: \(id)
Título: \(titulo)
Autor: \(autor)
Ano: \(anoPublicacao)
Status: \(status)
-----------------------------
""")
}
}

// MARK: - Classe Biblioteca

class Biblioteca {
    
private var livros: [Livro] = []
    
func adicionarLivro(_ livro: Livro) {
 
let existe = livros.contains {
$0.id == livro.id
}
 
if existe {
print("Já existe um livro com este ID.")
return
}
 
livros.append(livro)
print("Livro cadastrado com sucesso.")
}
 
func listarLivros() {
 
if livros.isEmpty {
print("Nenhum livro cadastrado.")
return
}
 
for livro in livros {
livro.exibirDetalhes()
}
}
 
func buscarPorId(_ id: Int) -> Livro? {
 
return livros.first {
$0.id == id
}
}
 
func buscarPorTitulo(_ trecho: String) {
 
let resultados = livros.filter {
$0.titulo.lowercased()
.contains(trecho.lowercased())
}
 
if resultados.isEmpty {
print("Nenhum livro encontrado.")
return
}
 
for livro in resultados {
livro.exibirDetalhes()
}
}
 
func atualizarLivro(
id: Int,
novoTitulo: String,
novoAutor: String,
novoAno: Int
) {
 
guard let livro = buscarPorId(id) else {
print("Livro não encontrado.")
return
}
 
livro.atualizarDados(
titulo: novoTitulo,
autor: novoAutor,
anoPublicacao: novoAno
)
 
print("Livro atualizado com sucesso.")
}
 
func removerLivro(id: Int) {
 
let quantidadeAntes = livros.count
 
livros.removeAll {
$0.id == id
}
 
if livros.count < quantidadeAntes {
print("Livro removido com sucesso.")
} else {
print("Livro não encontrado.")
}
}
 
func emprestarLivro(id: Int) {
 
guard let livro = buscarPorId(id) else {
print("Livro não encontrado.")
return
}
 
livro.emprestar()
}
 
func devolverLivro(id: Int) {
 
guard let livro = buscarPorId(id) else {
print("Livro não encontrado.")
return
}
 
livro.devolver()
}
}
 
// MARK: - Menu
 
func exibirMenu() {
 
print("""
 
===== SISTEMA DE BIBLIOTECA =====
 
1 - Cadastrar Livro
2 - Listar Livros
3 - Buscar Livro por ID
4 - Buscar Livro por Título
5 - Atualizar Livro
6 - Emprestar Livro
7 - Devolver Livro
8 - Remover Livro
0 - Sair
 
Escolha uma opção:
 
""")
}
 
// MARK: - Programa Principal
 
let biblioteca = Biblioteca()
 
while true {
 
exibirMenu()
 
guard let entrada = readLine(),
let opcao = Int(entrada) else {
 
print("Digite uma opção válida.")
continue
}
 
switch opcao {
 
case 1:
 
print("ID:")
let id = Int(readLine() ?? "") ?? 0
 
print("Título:")
let titulo = readLine() ?? ""
 
print("Autor:")
let autor = readLine() ?? ""
 
print("Ano de publicação:")
let ano = Int(readLine() ?? "") ?? 0
 
let livro = Livro(
id: id,
titulo: titulo,
autor: autor,
anoPublicacao: ano
)
 
biblioteca.adicionarLivro(livro)
 
case 2:
 
biblioteca.listarLivros()
 
case 3:
 
print("Digite o ID:")
 
let id = Int(readLine() ?? "") ?? 0
 
if let livro = biblioteca.buscarPorId(id) {
livro.exibirDetalhes()
} else {
print("Livro não encontrado.")
}
 
case 4:
    
print("Digite parte do título:")
 
let trecho = readLine() ?? ""
 
biblioteca.buscarPorTitulo(trecho)
 
case 5:
 
print("ID do livro:")
let id = Int(readLine() ?? "") ?? 0
 
print("Novo título:")
let titulo = readLine() ?? ""
 
print("Novo autor:")
let autor = readLine() ?? ""
 
print("Novo ano:")
let ano = Int(readLine() ?? "") ?? 0
 
biblioteca.atualizarLivro(
id: id,
novoTitulo: titulo,
novoAutor: autor,
novoAno: ano
)
 
case 6:
 
print("ID do livro:")
let id = Int(readLine() ?? "") ?? 0
 
biblioteca.emprestarLivro(id: id)
 
case 7:
 
print("ID do livro:")
let id = Int(readLine() ?? "") ?? 0
 
biblioteca.devolverLivro(id: id)
 
case 8:
 
print("ID do livro:")
let id = Int(readLine() ?? "") ?? 0
 
biblioteca.removerLivro(id: id)
 
case 0:
 
print("Encerrando sistema...")
exit(0)
 
default:
 
print("Opção inválida.")
}
}
