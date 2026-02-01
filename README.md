# FitDash

Dashboard de análise de dados de saúde e exercícios do Apple Health e Fitness.

## 📋 Objetivo do Projeto

Criar um aplicativo para o ecossistema Apple que lê dados do Apple Health (Saúde) e Apple Fitness, permitindo:

- **Extração de dados** através das APIs oficiais (HealthKit e WorkoutKit)
- **Dashboards e tabelas** com informações detalhadas de exercícios gravados
- **Precisão total** - valores nunca são arredondados
- **Visualização flexível** - opção de ver dados em horas e minutos
- **Análises personalizadas** - quanto tempo de cada tipo de exercício foi executado

## 🎯 Casos de Uso

- Visualizar histórico completo de treinos com precisão de segundos
- Comparar tempo dedicado a diferentes tipos de exercício
- Acompanhar evolução ao longo do tempo
- Exportar dados para análises adicionais
- Gerar relatórios personalizados de atividade física

## 🛠 Stack Tecnológico Recomendado

### Recomendação: Swift + SwiftUI

**Por que Swift?**

Dado que você conhece TypeScript, a transição para Swift será natural. Swift tem:
- Sintaxe moderna e similar ao TypeScript em muitos aspectos
- **Acesso nativo completo ao HealthKit** (API oficial da Apple para dados de saúde)
- **Acesso ao WorkoutKit** (API para dados de treinos)
- Melhor performance e integração com o ecossistema Apple
- Suporte oficial da Apple e documentação extensa

**Por que SwiftUI?**

- Framework declarativo moderno (similar ao React)
- Código compartilhado entre iOS, watchOS e macOS
- Desenvolvimento mais rápido de interfaces
- Preview em tempo real no Xcode

### Alternativas Consideradas

| Tecnologia | Prós | Contras | Veredicto |
|------------|------|---------|-----------|
| **React Native** | Você já conhece TS | Acesso limitado ao HealthKit, depende de bibliotecas de terceiros | ❌ Não recomendado |
| **Flutter** | UI moderna | Acesso limitado ao HealthKit, integração mais complexa | ❌ Não recomendado |
| **Python** | Você conhece bem | Impossível criar apps nativos iOS | ❌ Não aplicável |
| **Swift + SwiftUI** | Acesso completo às APIs nativas | Curva de aprendizado | ✅ **Recomendado** |

## 🏗 Arquitetura Proposta

```
FitDash/
├── FitDashApp/                 # App principal iOS
│   ├── Views/                  # Telas SwiftUI
│   │   ├── DashboardView.swift
│   │   ├── WorkoutListView.swift
│   │   ├── WorkoutDetailView.swift
│   │   └── SettingsView.swift
│   ├── Models/                 # Modelos de dados
│   │   ├── Workout.swift
│   │   ├── ExerciseType.swift
│   │   └── TimeFormat.swift
│   ├── Services/               # Lógica de negócio
│   │   ├── HealthKitManager.swift
│   │   ├── WorkoutDataService.swift
│   │   └── ChartDataService.swift
│   └── Utils/                  # Utilitários
│       ├── TimeFormatter.swift
│       └── Constants.swift
├── FitDashWatch/               # App Apple Watch (opcional)
└── Shared/                     # Código compartilhado
    └── Models/
```

### Camadas

1. **HealthKit Layer**: Comunicação com a API do HealthKit
2. **Data Layer**: Processamento e formatação dos dados
3. **Presentation Layer**: SwiftUI views e componentes de UI
4. **Chart Layer**: Visualização de dados (usando Swift Charts)

## 🚀 Setup do Ambiente de Desenvolvimento

### Pré-requisitos

- [x] macOS (você já tem)
- [ ] Xcode (versão mais recente da App Store)
- [ ] Conta Apple ID (para testar em dispositivo físico)
- [ ] iPhone e Apple Watch (você já tem)

### Passos Iniciais

1. **Instalar Xcode**
   ```bash
   # Instalar via App Store ou
   xcode-select --install
   ```

2. **Criar novo projeto**
   - Abrir Xcode
   - File > New > Project
   - Escolher "iOS App"
   - Interface: SwiftUI
   - Language: Swift

3. **Configurar HealthKit**
   - Adicionar capability "HealthKit" no projeto
   - Configurar `Info.plist` com permissões necessárias

4. **Estrutura inicial do projeto**
   ```swift
   // Exemplo de estrutura básica
   import SwiftUI
   import HealthKit

   @main
   struct FitDashApp: App {
       var body: some Scene {
           WindowGroup {
               ContentView()
           }
       }
   }
   ```

## 📱 Como Testar

### Simulador iOS

**Vantagens:**
- Rápido para desenvolvimento de UI
- Não precisa de dispositivo físico
- Fácil debug

**Limitações:**
- ⚠️ **HealthKit tem funcionalidade limitada no simulador**
- Não tem Apple Watch real
- Alguns sensores não funcionam

**Como usar:**
1. No Xcode: Product > Destination > Escolher simulador
2. Cmd + R para rodar
3. Adicionar dados de teste manualmente no app Saúde do simulador

### Dispositivo Físico (iPhone)

**Necessário para:**
- Testar com dados reais do HealthKit
- Testar integração com Apple Watch
- Validar performance real

**Setup:**

1. **Conectar iPhone ao Mac via cabo**

2. **Configurar dispositivo no Xcode**
   - Window > Devices and Simulators
   - Adicionar seu iPhone

3. **Configurar certificado de desenvolvedor**
   - Xcode > Preferences > Accounts
   - Adicionar sua Apple ID
   - Manage Certificates > Create (desenvolvimento)

4. **Rodar no dispositivo**
   - Product > Destination > Seu iPhone
   - Cmd + R
   - **Primeira vez:** Confiar no desenvolvedor
     - Settings > General > VPN & Device Management
     - Confiar no seu certificado

5. **Conceder permissões HealthKit**
   - O app vai pedir permissões na primeira execução
   - Você pode escolher quais dados compartilhar

### Apple Watch

**Requisitos:**
- iPhone pareado com Apple Watch
- Xcode configurado com watchOS target

**Setup:**
1. Adicionar watchOS target ao projeto
2. Garantir que o Watch está pareado e desbloqueado
3. Selecionar o scheme do Watch no Xcode
4. Rodar (levará alguns minutos na primeira vez)

## 📊 Funcionalidades Planejadas

### MVP (Minimum Viable Product)

- [ ] Autenticação e permissões HealthKit
- [ ] Listar todos os treinos gravados
- [ ] Exibir detalhes de cada treino (tipo, duração, data)
- [ ] Visualizar tempo total por tipo de exercício
- [ ] Toggle entre formato horas:minutos e decimal
- [ ] Precisão total (sem arredondamento)

### Funcionalidades Futuras

- [ ] Gráficos de evolução ao longo do tempo
- [ ] Filtros por data, tipo de exercício
- [ ] Exportação de dados (CSV, JSON)
- [ ] Comparação entre períodos
- [ ] Metas e objetivos
- [ ] App para Apple Watch
- [ ] Sincronização via iCloud
- [ ] Widget para tela inicial

## 📚 Recursos de Aprendizado Swift

### Para quem vem do TypeScript

- [Swift for TypeScript Developers](https://www.swiftbysundell.com/)
- [100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)
- [Apple Swift Documentation](https://docs.swift.org/swift-book/)

### HealthKit Específico

- [HealthKit Framework Documentation](https://developer.apple.com/documentation/healthkit)
- [Accessing Health Records](https://developer.apple.com/documentation/healthkit/hkhealthstore)
- [Reading Workout Data](https://developer.apple.com/documentation/healthkit/workouts_and_activity_rings)

## 🔐 Privacidade e Segurança

- Dados do HealthKit nunca saem do dispositivo sem consentimento explícito
- Todas as leituras requerem permissão do usuário
- Dados armazenados localmente de forma segura
- Compliance com guidelines da Apple para apps de saúde

## 📝 Convenções de Código

- Swift Style Guide da Apple/Google
- Comentários em português (ou inglês, a definir)
- Commits semânticos (conventional commits)
- Valores numéricos sempre em Double para evitar perda de precisão

## 🎯 Próximos Passos

1. **Instalar Xcode e criar projeto inicial**
2. **Tutorial básico de Swift/SwiftUI** (2-3 dias)
3. **Configurar HealthKit e testar leitura de dados**
4. **Implementar primeira tela listando treinos**
5. **Adicionar visualização de detalhes**
6. **Implementar dashboards e gráficos**

## 🤝 Contribuindo

Este é um projeto pessoal, mas ideias e sugestões são bem-vindas!

## 📄 Licença

A definir

---

**Status do Projeto:** 🚀 Planejamento inicial

**Última Atualização:** 2026-02-01
