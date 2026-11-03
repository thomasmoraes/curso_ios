import SwiftUI

struct Aluno: Identifiable {
    let id = UUID()
    let nome: String
    let nota1: Double
    let nota2: Double

    var media: Double {
        (nota1 + nota2) / 2
    }

    var situacao: String {
        media >= 7 ? "Aprovado" : "Reprovado"
    }
}

struct ContentView: View {

    @State private var nome = ""
    @State private var nota1 = ""
    @State private var nota2 = ""

    @State private var alunos: [Aluno] = []
    @State private var mensagemErro = ""

    var totalAprovados: Int {
        alunos.filter { $0.media >= 7 }.count
    }

    var totalReprovados: Int {
        alunos.filter { $0.media < 7 }.count
    }

    var body: some View {

        ScrollView {

            VStack(spacing: 25) {

                // CABEÇALHO
                VStack(spacing: 10) {

                    Image(systemName: "graduationcap.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)

                    Text("Minha Turma")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Cadastre alunos e acompanhe os resultados")
                        .foregroundColor(.gray)
                }
                .padding(.top)

                // FORMULÁRIO
                VStack(alignment: .leading, spacing: 15) {

                    Label("Cadastrar aluno",
                          systemImage: "person.badge.plus")
                        .font(.title3)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 5) {

                        Text("Nome do aluno")
                            .fontWeight(.medium)

                        TextField("Digite o nome completo",
                                  text: $nome)
                            .textFieldStyle(.roundedBorder)
                    }

                    HStack {

                        VStack(alignment: .leading) {
                            Text("Nota 1")
                                .fontWeight(.medium)

                            TextField("0 a 10",
                                      text: $nota1)
                                .textFieldStyle(.roundedBorder)
                        }

                        VStack(alignment: .leading) {
                            Text("Nota 2")
                                .fontWeight(.medium)

                            TextField("0 a 10",
                                      text: $nota2)
                                .textFieldStyle(.roundedBorder)
                        }
                    }

                    if !mensagemErro.isEmpty {
                        Text(mensagemErro)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button(action: cadastrarAluno) {

                        Label("Cadastrar aluno",
                              systemImage: "plus.circle.fill")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.08),
                        radius: 6)

                // RESUMO
                VStack(alignment: .leading, spacing: 15) {

                    Text("Resumo da turma")
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {

                        resumoCard(
                            icone: "person.3.fill",
                            valor: alunos.count,
                            titulo: "Alunos",
                            cor: .blue
                        )

                        resumoCard(
                            icone: "checkmark.circle.fill",
                            valor: totalAprovados,
                            titulo: "Aprovados",
                            cor: .green
                        )

                        resumoCard(
                            icone: "xmark.circle.fill",
                            valor: totalReprovados,
                            titulo: "Reprovados",
                            cor: .red
                        )
                    }
                }

                // LISTAGEM
                VStack(alignment: .leading, spacing: 15) {

                    HStack {

                        Text("Alunos cadastrados")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        Text("\(alunos.count) registros")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }

                    if alunos.isEmpty {

                        VStack(spacing: 10) {

                            Image(systemName: "tray")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)

                            Text("Nenhum aluno cadastrado")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)

                    } else {

                        ForEach(alunos) { aluno in

                            HStack {

                                VStack(alignment: .leading, spacing: 5) {

                                    Text(aluno.nome)
                                        .font(.headline)

                                    Text(aluno.situacao)
                                        .foregroundColor(
                                            aluno.media >= 7
                                            ? .green
                                            : .red
                                        )
                                        .fontWeight(.semibold)

                                    Text("Média: \(aluno.media, specifier: "%.1f")")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }

                                Spacer()

                                Button {

                                    removerAluno(aluno)

                                } label: {

                                    Image(systemName: "trash.fill")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(
                                color: .black.opacity(0.08),
                                radius: 4,
                                x: 0,
                                y: 2
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Funções

    func cadastrarAluno() {

        mensagemErro = ""

        guard !nome.trimmingCharacters(in: .whitespaces).isEmpty else {
            mensagemErro = "Informe o nome do aluno."
            return
        }

        guard let n1 = Double(nota1),
              let n2 = Double(nota2) else {

            mensagemErro = "As notas devem ser numéricas."
            return
        }

        guard n1 >= 0 && n1 <= 10 &&
              n2 >= 0 && n2 <= 10 else {

            mensagemErro = "As notas devem estar entre 0 e 10."
            return
        }

        alunos.append(
            Aluno(
                nome: nome,
                nota1: n1,
                nota2: n2
            )
        )

        nome = ""
        nota1 = ""
        nota2 = ""
    }

    func removerAluno(_ aluno: Aluno) {

        alunos.removeAll { item in
            item.id == aluno.id
        }
    }

    @ViewBuilder
    func resumoCard(
        icone: String,
        valor: Int,
        titulo: String,
        cor: Color
    ) -> some View {

        VStack(spacing: 8) {

            Image(systemName: icone)
                .foregroundColor(cor)
                .font(.title)

            Text("\(valor)")
                .font(.title)
                .fontWeight(.bold)

            Text(titulo)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.08),
                radius: 4)
    }
}

#Preview {
    ContentView()
}
