import 'package:flutter/material.dart';
import 'theme.dart';

// ──────────────────────────────────────────────────────────────────────────
// Models
// ──────────────────────────────────────────────────────────────────────────

class FreelancerUser {
  final String id, name, title, city, rate, avatar, bio, level;
  final Color avatarBg;
  final double rating;
  final int reviews, completion, active, completed;
  final String responseTime, earnings, earningsThisMonth;
  final List<String> skills;
  final bool videoIntro;
  const FreelancerUser({
    required this.id, required this.name, required this.title, required this.city,
    required this.rate, required this.avatar, required this.avatarBg, required this.rating,
    required this.reviews, required this.completion, required this.responseTime, required this.level,
    required this.skills, required this.bio, required this.earnings, required this.earningsThisMonth,
    required this.active, required this.completed, required this.videoIntro,
  });
}

class CompanyUser {
  final String id, name, industry, city, size, avatar, spent;
  final Color avatarBg;
  final bool verified;
  final double rating;
  final int reviewsTotal, hiresTotal, openRoles, activeContracts;
  const CompanyUser({
    required this.id, required this.name, required this.industry, required this.city,
    required this.size, required this.avatar, required this.avatarBg, required this.verified,
    required this.rating, required this.reviewsTotal, required this.hiresTotal, required this.spent,
    required this.openRoles, required this.activeContracts,
  });
}

class FreelancerCardData {
  final String id, name, title, city, avatar, level;
  final Color bg;
  final int rate, reviews, match;
  final double rating;
  final List<String> skills;
  final bool verified, available;
  const FreelancerCardData({
    required this.id, required this.name, required this.title, required this.city,
    required this.rate, required this.rating, required this.reviews, required this.skills,
    required this.avatar, required this.bg, required this.match, required this.level,
    required this.verified, required this.available,
  });
}

class CompanyCardData {
  final String id, name, industry, city, avatar;
  final Color bg;
  final double rating;
  final int jobs, hires;
  final bool verified;
  const CompanyCardData({
    required this.id, required this.name, required this.industry, required this.city,
    required this.avatar, required this.bg, required this.rating, required this.jobs,
    required this.verified, required this.hires,
  });
}

class JobData {
  final String id, title, company, companyId, companyAvatar, type, duration, budget,
      location, posted, description;
  final Color companyBg;
  final bool verified, urgent;
  final int proposals, match;
  final List<String> skills;
  const JobData({
    required this.id, required this.title, required this.company, required this.companyId,
    required this.companyAvatar, required this.companyBg, required this.verified, required this.type,
    required this.duration, required this.budget, required this.location, required this.posted,
    required this.proposals, required this.urgent, required this.skills, required this.description,
    required this.match,
  });
}

class ApplicationData {
  final String id, jobId, jobTitle, company, companyAvatar, status, appliedAt, bid;
  final Color companyBg;
  const ApplicationData({
    required this.id, required this.jobId, required this.jobTitle, required this.company,
    required this.companyAvatar, required this.companyBg, required this.status, required this.appliedAt,
    required this.bid,
  });
}

class ChatData {
  final String id, name, avatar, lastMessage, time;
  final Color bg;
  final bool verified, online;
  final int unread;
  const ChatData({
    required this.id, required this.name, required this.avatar, required this.bg,
    required this.verified, required this.lastMessage, required this.time,
    required this.unread, required this.online,
  });
}

class MessageData {
  final String from, text, time;
  const MessageData(this.from, this.text, this.time);
}

class NotificationData {
  final String id, type, title, detail, time, icon;
  final bool unread;
  const NotificationData({
    required this.id, required this.type, required this.title, required this.detail,
    required this.time, required this.unread, required this.icon,
  });
}

class ReviewData {
  final String id, from, company, avatar, project, date, text;
  final Color bg;
  final int rating;
  const ReviewData({
    required this.id, required this.from, required this.company, required this.avatar,
    required this.bg, required this.rating, required this.project, required this.date,
    required this.text,
  });
}

class PortfolioData {
  final String id, title, tag;
  final Color cover, accent;
  const PortfolioData({
    required this.id, required this.title, required this.tag, required this.cover,
    required this.accent,
  });
}

class PaymentData {
  final String id, desc, status, date, method;
  final int amount;
  const PaymentData({
    required this.id, required this.desc, required this.amount, required this.status,
    required this.date, required this.method,
  });
}

class CandidateData {
  final String id, name, avatar, bid, appliedAt;
  final Color bg;
  final int match;
  const CandidateData({
    required this.id, required this.name, required this.avatar, required this.bg,
    required this.match, required this.bid, required this.appliedAt,
  });
}

class CompanyJobData {
  final String id, title, status, posted;
  final int proposals, shortlist, views;
  const CompanyJobData({
    required this.id, required this.title, required this.status, required this.proposals,
    required this.shortlist, required this.views, required this.posted,
  });
}

class StatusLabel {
  final String label;
  final Color fg, bg;
  const StatusLabel(this.label, this.fg, this.bg);
}

// ──────────────────────────────────────────────────────────────────────────
// Mock data — Mozambique context (pulled from claude design data.jsx)
// ──────────────────────────────────────────────────────────────────────────

const currentFreelancer = FreelancerUser(
  id: 'u1',
  name: 'Aida Macuácua',
  title: 'Designer de produto sénior',
  city: 'Maputo, Moçambique',
  rate: '4.500 MZN/h',
  avatar: 'AM',
  avatarBg: LinkUpColors.gold,
  rating: 4.9,
  reviews: 87,
  completion: 98,
  responseTime: '< 2h',
  level: 'Top Rated',
  skills: ['UI/UX', 'Figma', 'Design System', 'Prototyping', 'Pesquisa', 'Branding'],
  bio: 'Designo produtos digitais que respeitam o utilizador. 6 anos a desenhar para fintech, agritech e ONGs em África Lusófona.',
  earnings: '847.500 MZN',
  earningsThisMonth: '128.000 MZN',
  active: 3,
  completed: 41,
  videoIntro: true,
);

const currentCompany = CompanyUser(
  id: 'c1',
  name: 'Banco Hércules',
  industry: 'Serviços Financeiros',
  city: 'Maputo, Moçambique',
  size: '500–1000 colaboradores',
  avatar: 'BH',
  avatarBg: LinkUpColors.navy,
  verified: true,
  rating: 4.7,
  reviewsTotal: 34,
  hiresTotal: 67,
  spent: '14.2M MZN',
  openRoles: 5,
  activeContracts: 8,
);

const freelancers = <FreelancerCardData>[
  FreelancerCardData(id: 'f1', name: 'Délcio Nhantumbo', title: 'Engenheiro Full-Stack', city: 'Maputo', rate: 5200, rating: 5.0, reviews: 64, skills: ['React', 'Node.js', 'Postgres', 'AWS'], avatar: 'DN', bg: LinkUpColors.green, match: 96, level: 'Top Rated', verified: true, available: true),
  FreelancerCardData(id: 'f2', name: 'Aida Macuácua', title: 'Designer de produto', city: 'Maputo', rate: 4500, rating: 4.9, reviews: 87, skills: ['UI/UX', 'Figma', 'Design System'], avatar: 'AM', bg: LinkUpColors.gold, match: 94, level: 'Top Rated', verified: true, available: true),
  FreelancerCardData(id: 'f3', name: 'Hélder Massingue', title: 'Especialista em Marketing Digital', city: 'Beira', rate: 3200, rating: 4.8, reviews: 52, skills: ['SEO', 'Meta Ads', 'Conteúdo', 'Analytics'], avatar: 'HM', bg: LinkUpColors.navy, match: 91, level: 'Rising Talent', verified: true, available: false),
  FreelancerCardData(id: 'f4', name: 'Eunice Cossa', title: 'Tradutora EN→PT/Changana', city: 'Maputo', rate: 1800, rating: 4.9, reviews: 119, skills: ['Tradução', 'Revisão', 'Localização'], avatar: 'EC', bg: LinkUpColors.greenDark, match: 88, level: 'Top Rated', verified: true, available: true),
  FreelancerCardData(id: 'f5', name: 'Tomás Sitoe', title: 'Contabilista certificado', city: 'Matola', rate: 2400, rating: 4.7, reviews: 38, skills: ['IRPC', 'Folhas de salário', 'Auditoria'], avatar: 'TS', bg: LinkUpColors.gold, match: 84, level: 'Rising Talent', verified: false, available: true),
  FreelancerCardData(id: 'f6', name: 'Marta Chissano', title: 'Fotógrafa & videógrafa', city: 'Maputo', rate: 2800, rating: 4.9, reviews: 71, skills: ['Foto', 'Vídeo', 'Edição', 'Drone'], avatar: 'MC', bg: LinkUpColors.navy, match: 80, level: 'Top Rated', verified: true, available: true),
];

const companies = <CompanyCardData>[
  CompanyCardData(id: 'c1', name: 'Banco Hércules', industry: 'Serviços Financeiros', city: 'Maputo', avatar: 'BH', bg: LinkUpColors.navy, rating: 4.7, jobs: 5, verified: true, hires: 67),
  CompanyCardData(id: 'c2', name: 'AgroMoz Lda', industry: 'Agricultura', city: 'Nampula', avatar: 'AM', bg: LinkUpColors.green, rating: 4.6, jobs: 3, verified: true, hires: 22),
  CompanyCardData(id: 'c3', name: 'Mukuru Tech', industry: 'Fintech', city: 'Maputo', avatar: 'MT', bg: LinkUpColors.gold, rating: 4.9, jobs: 8, verified: true, hires: 134),
  CompanyCardData(id: 'c4', name: 'Cervejas de Moçambique', industry: 'Bebidas & Retalho', city: 'Matola', avatar: 'CM', bg: LinkUpColors.greenDark, rating: 4.5, jobs: 2, verified: true, hires: 41),
  CompanyCardData(id: 'c5', name: 'Vodacom Moçambique', industry: 'Telecomunicações', city: 'Maputo', avatar: 'VM', bg: LinkUpColors.navy, rating: 4.8, jobs: 6, verified: true, hires: 88),
  CompanyCardData(id: 'c6', name: 'Hospital Privado da Matola', industry: 'Saúde', city: 'Matola', avatar: 'HM', bg: LinkUpColors.gold, rating: 4.4, jobs: 1, verified: false, hires: 9),
];

const jobs = <JobData>[
  JobData(
    id: 'j1', title: 'Redesenhar app de mobile banking',
    company: 'Banco Hércules', companyId: 'c1', companyAvatar: 'BH', companyBg: LinkUpColors.navy, verified: true,
    type: 'Projecto fixo', duration: '6–8 semanas', budget: '250.000–400.000 MZN',
    location: 'Remoto · Moçambique', posted: 'há 2 dias', proposals: 12, urgent: true,
    skills: ['UI/UX', 'Figma', 'Design System', 'Mobile'],
    description: 'Procuramos designer sénior para liderar o redesenho da nossa app de mobile banking. O projecto inclui pesquisa com utilizadores em 4 províncias, redesenho do design system e entrega de protótipo de alta fidelidade.',
    match: 96,
  ),
  JobData(
    id: 'j2', title: 'Desenvolvimento de plataforma de e-commerce',
    company: 'AgroMoz Lda', companyId: 'c2', companyAvatar: 'AM', companyBg: LinkUpColors.green, verified: true,
    type: 'Por hora', duration: '3 meses', budget: '4.000–6.000 MZN/h',
    location: 'Maputo · Híbrido', posted: 'há 5 dias', proposals: 8, urgent: false,
    skills: ['React', 'Node.js', 'Stripe'],
    description: 'Plataforma para venda directa de produtos agrícolas. Stack moderno, integrações de pagamento locais (M-Pesa, e-Mola).',
    match: 78,
  ),
  JobData(
    id: 'j3', title: 'Tradução de manual técnico EN → PT',
    company: 'Vodacom Moçambique', companyId: 'c5', companyAvatar: 'VM', companyBg: LinkUpColors.navy, verified: true,
    type: 'Projecto fixo', duration: '2 semanas', budget: '45.000 MZN',
    location: 'Remoto', posted: 'ontem', proposals: 5, urgent: false,
    skills: ['Tradução', 'Técnico', 'Revisão'],
    description: '120 páginas de documentação técnica. Necessária familiaridade com terminologia de telecomunicações.',
    match: 72,
  ),
  JobData(
    id: 'j4', title: 'Campanha de marketing digital — Lançamento de produto',
    company: 'Cervejas de Moçambique', companyId: 'c4', companyAvatar: 'CM', companyBg: LinkUpColors.greenDark, verified: true,
    type: 'Projecto fixo', duration: '4 semanas', budget: '180.000 MZN',
    location: 'Maputo', posted: 'há 3 dias', proposals: 17, urgent: true,
    skills: ['Marketing', 'Meta Ads', 'Conteúdo'],
    description: 'Lançamento nacional de novo produto. Necessitamos de estratégia, criação de conteúdo e gestão de campanha.',
    match: 88,
  ),
  JobData(
    id: 'j5', title: 'Auditoria contabilística trimestral',
    company: 'Mukuru Tech', companyId: 'c3', companyAvatar: 'MT', companyBg: LinkUpColors.gold, verified: true,
    type: 'Recorrente', duration: 'Trimestral', budget: '90.000 MZN/trimestre',
    location: 'Maputo · Presencial', posted: 'há 1 semana', proposals: 4, urgent: false,
    skills: ['Auditoria', 'IRPC', 'Compliance'],
    description: 'Auditoria interna trimestral. Contabilista certificado com experiência em fintech.',
    match: 65,
  ),
];

const applications = <ApplicationData>[
  ApplicationData(id: 'a1', jobId: 'j1', jobTitle: 'Redesenhar app de mobile banking', company: 'Banco Hércules', companyAvatar: 'BH', companyBg: LinkUpColors.navy, status: 'shortlisted', appliedAt: 'há 2 dias', bid: '320.000 MZN'),
  ApplicationData(id: 'a2', jobId: 'j4', jobTitle: 'Campanha digital — Lançamento', company: 'Cervejas de Moçambique', companyAvatar: 'CM', companyBg: LinkUpColors.greenDark, status: 'em-revisao', appliedAt: 'há 4 dias', bid: '175.000 MZN'),
  ApplicationData(id: 'a3', jobId: 'j2', jobTitle: 'E-commerce AgroMoz', company: 'AgroMoz Lda', companyAvatar: 'AM', companyBg: LinkUpColors.green, status: 'em-revisao', appliedAt: 'há 1 semana', bid: '5.500 MZN/h'),
  ApplicationData(id: 'a4', jobId: 'jx1', jobTitle: 'Identidade visual — Café Maputo', company: 'Café Maputo', companyAvatar: 'CF', companyBg: LinkUpColors.gold, status: 'rejeitada', appliedAt: 'há 2 semanas', bid: '60.000 MZN'),
  ApplicationData(id: 'a5', jobId: 'jx2', jobTitle: 'Sistema de gestão escolar', company: 'Escola Internacional', companyAvatar: 'EI', companyBg: LinkUpColors.navy, status: 'aceite', appliedAt: 'há 3 semanas', bid: '420.000 MZN'),
];

const chats = <ChatData>[
  ChatData(id: 'ch1', name: 'Banco Hércules · Inês Mondlane', avatar: 'BH', bg: LinkUpColors.navy, verified: true, lastMessage: 'Podemos marcar uma chamada amanhã às 14h?', time: '14:32', unread: 2, online: true),
  ChatData(id: 'ch2', name: 'AgroMoz · Filipe Cumbe', avatar: 'AM', bg: LinkUpColors.green, verified: true, lastMessage: 'Enviei o brief actualizado. Vê quando puderes.', time: '11:08', unread: 0, online: false),
  ChatData(id: 'ch3', name: 'Mukuru Tech · Helena Sousa', avatar: 'MT', bg: LinkUpColors.gold, verified: true, lastMessage: 'Obrigada pela proposta! Vou rever com a equipa.', time: 'ontem', unread: 0, online: true),
  ChatData(id: 'ch4', name: 'Cervejas Moçambique · Paulo Mahanjane', avatar: 'CM', bg: LinkUpColors.greenDark, verified: true, lastMessage: 'Tu: Anexo a primeira ronda de mockups', time: 'qua', unread: 0, online: false),
  ChatData(id: 'ch5', name: 'Vodacom · Cláudia Tembe', avatar: 'VM', bg: LinkUpColors.navy, verified: true, lastMessage: 'Bom dia! Recebeste o ficheiro?', time: 'ter', unread: 1, online: false),
];

const messagesCh1 = <MessageData>[
  MessageData('them', 'Olá Aida, vimos o teu portfólio e gostámos muito do trabalho com a Letshego.', '09:14'),
  MessageData('them', 'Estamos a redesenhar a nossa app de mobile banking e adoraríamos a tua opinião.', '09:14'),
  MessageData('me', 'Olá Inês! Obrigada pela mensagem. Vi a vaga ontem e enviei a minha proposta.', '09:32'),
  MessageData('me', 'Tenho disponibilidade a partir do dia 5 de Maio.', '09:33'),
  MessageData('them', 'Perfeito. Já recebemos a proposta. Tens uma estrutura muito clara para a fase de descoberta.', '11:48'),
  MessageData('them', 'Podemos marcar uma chamada amanhã às 14h?', '14:32'),
];

const notifications = <NotificationData>[
  NotificationData(id: 'n1', type: 'message', title: 'Nova mensagem de Banco Hércules', detail: 'Inês Mondlane respondeu à tua proposta', time: 'há 12 min', unread: true, icon: '💬'),
  NotificationData(id: 'n2', type: 'application', title: 'Foste pré-seleccionada', detail: 'Redesenhar app de mobile banking · Banco Hércules', time: 'há 2 h', unread: true, icon: '⭐'),
  NotificationData(id: 'n3', type: 'job', title: 'Nova oportunidade compatível', detail: 'Designer sénior para fintech · 96% match', time: 'há 5 h', unread: true, icon: '🎯'),
  NotificationData(id: 'n4', type: 'payment', title: 'Pagamento recebido', detail: '128.000 MZN de Cervejas de Moçambique', time: 'ontem', unread: false, icon: '💰'),
  NotificationData(id: 'n5', type: 'review', title: 'Nova avaliação', detail: 'Filipe Cumbe deixou-te 5 estrelas', time: 'há 2 dias', unread: false, icon: '⭐'),
  NotificationData(id: 'n6', type: 'system', title: 'Selo Top Rated renovado', detail: 'Mantiveste o teu nível por mais um trimestre', time: 'há 3 dias', unread: false, icon: '🏆'),
];

const reviews = <ReviewData>[
  ReviewData(id: 'r1', from: 'Filipe Cumbe', company: 'AgroMoz Lda', avatar: 'FC', bg: LinkUpColors.green, rating: 5, project: 'Design da app de logística', date: 'há 2 dias', text: 'Trabalho excepcional. Aida entendeu o nosso negócio e entregou acima do esperado. Recomendo sem hesitar.'),
  ReviewData(id: 'r2', from: 'Helena Sousa', company: 'Mukuru Tech', avatar: 'HS', bg: LinkUpColors.gold, rating: 5, project: 'Design system v2', date: 'há 3 semanas', text: 'Profissionalismo, comunicação clara e um olhar muito apurado. Já a contratámos para o próximo projecto.'),
  ReviewData(id: 'r3', from: 'Paulo Mahanjane', company: 'Cervejas de Moçambique', avatar: 'PM', bg: LinkUpColors.greenDark, rating: 5, project: 'Landing page de campanha', date: 'há 1 mês', text: 'Entregou no prazo, foi proactiva nos detalhes. Voltaríamos a trabalhar com ela.'),
  ReviewData(id: 'r4', from: 'Sandra Tembe', company: 'Maputo Living', avatar: 'ST', bg: LinkUpColors.navy, rating: 4, project: 'Identidade visual', date: 'há 2 meses', text: 'Boa execução. Algumas iterações a mais do que esperávamos, mas o resultado final é excelente.'),
];

const portfolio = <PortfolioData>[
  PortfolioData(id: 'p1', title: 'App de mobile banking — Letshego', tag: 'Fintech', cover: LinkUpColors.green, accent: LinkUpColors.gold),
  PortfolioData(id: 'p2', title: 'Sistema de gestão agrícola', tag: 'Agritech', cover: LinkUpColors.greenDark, accent: LinkUpColors.cream),
  PortfolioData(id: 'p3', title: 'Identidade visual Café Maputo', tag: 'Branding', cover: LinkUpColors.gold, accent: LinkUpColors.navy),
  PortfolioData(id: 'p4', title: 'Design system Mukuru', tag: 'Design System', cover: LinkUpColors.navy, accent: LinkUpColors.gold),
  PortfolioData(id: 'p5', title: 'Plataforma escolar EI', tag: 'EdTech', cover: Color(0xFFE8ECF1), accent: LinkUpColors.navy),
  PortfolioData(id: 'p6', title: 'Landing 2M Cervejas', tag: 'Marketing', cover: LinkUpColors.cream, accent: LinkUpColors.greenDark),
];

const payments = <PaymentData>[
  PaymentData(id: 'pay1', desc: 'Cervejas de Moçambique · Landing campaign', amount: 128000, status: 'recebido', date: '22 Abr 2026', method: 'M-Pesa'),
  PaymentData(id: 'pay2', desc: 'AgroMoz · Sprint 3 (milestone)', amount: 95000, status: 'em-escrow', date: '18 Abr 2026', method: 'Transferência'),
  PaymentData(id: 'pay3', desc: 'Mukuru Tech · Design system v2', amount: 215000, status: 'recebido', date: '02 Abr 2026', method: 'M-Pesa'),
  PaymentData(id: 'pay4', desc: 'Banco Hércules · Adiantamento', amount: 80000, status: 'pendente', date: '24 Abr 2026', method: 'Transferência'),
  PaymentData(id: 'pay5', desc: 'Escola Internacional · Final', amount: 180000, status: 'recebido', date: '15 Mar 2026', method: 'Transferência'),
];

const candidatesNovos = <CandidateData>[
  CandidateData(id: 'cd1', name: 'Délcio Nhantumbo', avatar: 'DN', bg: LinkUpColors.green, match: 96, bid: '290.000 MZN', appliedAt: 'há 2h'),
  CandidateData(id: 'cd2', name: 'Aida Macuácua', avatar: 'AM', bg: LinkUpColors.gold, match: 94, bid: '320.000 MZN', appliedAt: 'há 5h'),
  CandidateData(id: 'cd3', name: 'Hélder Massingue', avatar: 'HM', bg: LinkUpColors.navy, match: 87, bid: '275.000 MZN', appliedAt: 'ontem'),
];

const candidatesShortlist = <CandidateData>[
  CandidateData(id: 'cd4', name: 'Marta Chissano', avatar: 'MC', bg: LinkUpColors.navy, match: 92, bid: '340.000 MZN', appliedAt: 'há 3 dias'),
  CandidateData(id: 'cd5', name: 'Tomás Sitoe', avatar: 'TS', bg: LinkUpColors.gold, match: 89, bid: '310.000 MZN', appliedAt: 'há 4 dias'),
];

const candidatesEntrevista = <CandidateData>[
  CandidateData(id: 'cd6', name: 'Eunice Cossa', avatar: 'EC', bg: LinkUpColors.greenDark, match: 91, bid: '305.000 MZN', appliedAt: 'há 5 dias'),
];

const candidatesPipeline = <String, List<CandidateData>>{
  'novos': candidatesNovos,
  'shortlist': candidatesShortlist,
  'entrevista': candidatesEntrevista,
  'oferta': <CandidateData>[],
};

const companyJobs = <CompanyJobData>[
  CompanyJobData(id: 'cj1', title: 'Redesenhar app de mobile banking', status: 'activa', proposals: 12, shortlist: 3, views: 247, posted: '22 Abr 2026'),
  CompanyJobData(id: 'cj2', title: 'Frontend developer — Internet banking', status: 'activa', proposals: 18, shortlist: 5, views: 432, posted: '20 Abr 2026'),
  CompanyJobData(id: 'cj3', title: 'Especialista em compliance', status: 'activa', proposals: 6, shortlist: 2, views: 89, posted: '15 Abr 2026'),
  CompanyJobData(id: 'cj4', title: 'Tradução de relatório anual', status: 'fechada', proposals: 23, shortlist: 4, views: 312, posted: '01 Abr 2026'),
  CompanyJobData(id: 'cj5', title: 'Consultor em data warehousing', status: 'rascunho', proposals: 0, shortlist: 0, views: 0, posted: '—'),
];

const statusLabels = <String, StatusLabel>{
  'shortlisted': StatusLabel('Pré-seleccionada', LinkUpColors.green, LinkUpColors.pillGreenBg),
  'em-revisao': StatusLabel('Em revisão', LinkUpColors.goldDark, LinkUpColors.cream),
  'aceite': StatusLabel('Aceite', LinkUpColors.green, LinkUpColors.pillGreenBg),
  'rejeitada': StatusLabel('Não seleccionada', LinkUpColors.textMuted, LinkUpColors.pillNeutralBg),
};

// ──────────────────────────────────────────────────────────────────────────
// Team members (company side)
// ──────────────────────────────────────────────────────────────────────────
class TeamMember {
  final String id, name, email, role, avatar;
  final Color bg;
  final bool isOwner;
  const TeamMember({
    required this.id, required this.name, required this.email, required this.role,
    required this.avatar, required this.bg, this.isOwner = false,
  });
}

const teamMembers = <TeamMember>[
  TeamMember(id: 'tm1', name: 'Inês Mondlane', email: 'ines.mondlane@bancoherc.co.mz', role: 'Admin', avatar: 'IM', bg: LinkUpColors.navy, isOwner: true),
  TeamMember(id: 'tm2', name: 'Carlos Mucavele', email: 'carlos.mucavele@bancoherc.co.mz', role: 'Recruiter', avatar: 'CM', bg: LinkUpColors.green),
  TeamMember(id: 'tm3', name: 'Lúcia Bila', email: 'lucia.bila@bancoherc.co.mz', role: 'Finanças', avatar: 'LB', bg: LinkUpColors.gold),
  TeamMember(id: 'tm4', name: 'Jorge Mate', email: 'jorge.mate@bancoherc.co.mz', role: 'Visualizador', avatar: 'JM', bg: LinkUpColors.greenDark),
];

const teamRoles = <String, String>{
  'Admin': 'Acesso total · gerir equipa, faturação e vagas',
  'Recruiter': 'Publicar vagas, gerir candidatos e mensagens',
  'Finanças': 'Aprovar pagamentos e libertar escrow',
  'Visualizador': 'Apenas leitura · sem alterações',
};

// ──────────────────────────────────────────────────────────────────────────
// FAQ / Support
// ──────────────────────────────────────────────────────────────────────────
class FaqArticle {
  final String id, question, answer, category;
  const FaqArticle({required this.id, required this.question, required this.answer, required this.category});
}

const faqArticles = <FaqArticle>[
  FaqArticle(id: 'fq1', category: 'Pagamentos', question: 'Como funciona o pagamento em escrow?',
    answer: 'Os fundos da empresa são bloqueados no LinkUp assim que aceitas o projecto. Quando entregas cada milestone e a empresa valida, o valor correspondente é libertado para a tua carteira em até 24h.'),
  FaqArticle(id: 'fq2', category: 'Pagamentos', question: 'Quais são as taxas?',
    answer: 'O LinkUp cobra 8% sobre o valor de cada projecto concluído. Não há taxas fixas mensais nem custos de subscrição. Os levantamentos por M-Pesa têm custo zero; transferências bancárias custam 25 MZN por operação.'),
  FaqArticle(id: 'fq3', category: 'Disputas', question: 'O que acontece se não chegarmos a acordo?',
    answer: 'Podes abrir uma disputa em qualquer milestone. Um mediador independente do LinkUp analisa as conversas, anexos e entregas em até 3 dias úteis e propõe uma resolução vinculativa.'),
  FaqArticle(id: 'fq4', category: 'Verificação', question: 'Como obter o selo Ubuntu?',
    answer: 'Para freelancers: 5+ projectos concluídos com avaliação ≥ 4.5 + verificação de identidade. Para empresas: NUIT validado + histórico de 3 pagamentos sem incidentes.'),
  FaqArticle(id: 'fq5', category: 'Conta', question: 'Posso ter conta freelancer e empresa?',
    answer: 'Sim. Cada papel tem o seu perfil, faturação e histórico independentes. Podes alternar a partir do switch no topo da app sem terminar sessão.'),
  FaqArticle(id: 'fq6', category: 'Segurança', question: 'A minha conversa é privada?',
    answer: 'Todas as mensagens são encriptadas em trânsito e armazenadas com encriptação AES-256. Só tu e o destinatário têm acesso ao conteúdo. O LinkUp não usa o conteúdo das tuas conversas para treinar modelos.'),
];

const supportChannels = <({String label, String detail, IconData icon, String tag})>[
  (label: 'Chat ao vivo', detail: 'Resposta em ~3 minutos · 8h-22h', icon: Icons.chat_bubble_outline, tag: 'online'),
  (label: 'Email', detail: 'apoio@linkup.co.mz', icon: Icons.alternate_email, tag: '24h'),
  (label: 'WhatsApp', detail: '+258 84 100 0000', icon: Icons.phone_android, tag: '24h'),
];

// ──────────────────────────────────────────────────────────────────────────
// Wallet — withdrawals & payout methods
// ──────────────────────────────────────────────────────────────────────────
class WithdrawalRecord {
  final String id, date, method, status;
  final int amount, fee;
  const WithdrawalRecord({required this.id, required this.date, required this.method, required this.amount, required this.fee, required this.status});
}

const withdrawalHistory = <WithdrawalRecord>[
  WithdrawalRecord(id: 'wh1', date: '20 Abr 2026', method: 'M-Pesa · 84·····321', amount: 200000, fee: 0, status: 'concluído'),
  WithdrawalRecord(id: 'wh2', date: '02 Abr 2026', method: 'IBAN ····5482', amount: 350000, fee: 25, status: 'concluído'),
  WithdrawalRecord(id: 'wh3', date: '15 Mar 2026', method: 'M-Pesa · 84·····321', amount: 80000, fee: 0, status: 'concluído'),
  WithdrawalRecord(id: 'wh4', date: '28 Fev 2026', method: 'M-Pesa · 84·····321', amount: 120000, fee: 0, status: 'concluído'),
];

class PayoutMethod {
  final String id, name, masked, icon, type;
  final bool primary;
  const PayoutMethod({required this.id, required this.name, required this.masked, required this.icon, required this.type, this.primary = false});
}

const payoutMethods = <PayoutMethod>[
  PayoutMethod(id: 'pm1', name: 'M-Pesa', masked: '84·····321', icon: '📱', type: 'mobile', primary: true),
  PayoutMethod(id: 'pm2', name: 'Banco Hércules', masked: 'IBAN ····5482', icon: '🏦', type: 'bank'),
];

// ──────────────────────────────────────────────────────────────────────────
// Languages & currencies (settings radio lists)
// ──────────────────────────────────────────────────────────────────────────
class LanguageOption {
  final String code, label, native;
  const LanguageOption({required this.code, required this.label, required this.native});
}

const languages = <LanguageOption>[
  LanguageOption(code: 'pt', label: 'Português', native: 'Português (Moçambique)'),
  LanguageOption(code: 'en', label: 'English', native: 'English (US)'),
  LanguageOption(code: 'cha', label: 'Changana', native: 'Xichangana'),
  LanguageOption(code: 'mac', label: 'Macua', native: 'Emakhuwa'),
];

class CurrencyOption {
  final String code, label, symbol;
  const CurrencyOption({required this.code, required this.label, required this.symbol});
}

const currencies = <CurrencyOption>[
  CurrencyOption(code: 'MZN', label: 'Metical Moçambicano', symbol: 'MZN'),
  CurrencyOption(code: 'USD', label: 'Dólar Americano', symbol: '\$'),
  CurrencyOption(code: 'EUR', label: 'Euro', symbol: '€'),
  CurrencyOption(code: 'ZAR', label: 'Rand Sul-Africano', symbol: 'R'),
];

// ──────────────────────────────────────────────────────────────────────────
// Terms of Service sections
// ──────────────────────────────────────────────────────────────────────────
class TermsSection {
  final String title, body;
  const TermsSection({required this.title, required this.body});
}

const termsSections = <TermsSection>[
  TermsSection(
    title: '1. Uso da plataforma',
    body: 'O LinkUp é uma plataforma de intermediação entre freelancers e empresas em Moçambique. Ao criares uma conta, comprometes-te a usar o serviço de boa-fé, sem tentar enganar contrapartes ou contornar os mecanismos de pagamento e avaliação.',
  ),
  TermsSection(
    title: '2. Privacidade e dados',
    body: 'Recolhemos os dados estritamente necessários para operar a plataforma: identificação, contactos, histórico de transacções e conversas. Não vendemos dados a terceiros. Tens direito a aceder, corrigir ou eliminar os teus dados a qualquer momento via Configurações.',
  ),
  TermsSection(
    title: '3. Pagamentos e escrow',
    body: 'Os fundos de cada projecto ficam em escrow até validação de cada milestone. O LinkUp retém 8% do valor de cada projecto concluído como comissão. Os levantamentos via M-Pesa são gratuitos; transferências bancárias têm um custo fixo de 25 MZN.',
  ),
  TermsSection(
    title: '4. Disputas e mediação',
    body: 'Em caso de desacordo entre as partes, qualquer uma pode abrir uma disputa. O LinkUp aplica um processo de mediação independente em até 3 dias úteis, com base nas conversas e entregas registadas na plataforma. A decisão da mediação é vinculativa.',
  ),
  TermsSection(
    title: '5. Verificação Ubuntu',
    body: 'O selo Ubuntu certifica empresas com NUIT validado e histórico de pagamentos sem incidentes, e freelancers com identidade confirmada e ≥ 5 projectos concluídos com avaliação média ≥ 4.5. A perda dos critérios pode resultar na suspensão do selo.',
  ),
];

// ──────────────────────────────────────────────────────────────────────────
// Contract milestones (drill-down from contracts)
// ──────────────────────────────────────────────────────────────────────────
class MilestoneData {
  final String id, label, dueDate, status;
  final int amount;
  final int order;
  const MilestoneData({required this.id, required this.label, required this.amount, required this.dueDate, required this.status, required this.order});
}

const contractMilestones = <String, List<MilestoneData>>{
  'co1': [
    MilestoneData(id: 'm1', label: 'Pesquisa & descoberta', amount: 96000, dueDate: '02 Mai', status: 'concluido', order: 1),
    MilestoneData(id: 'm2', label: 'Wireframes & estrutura', amount: 96000, dueDate: '15 Mai', status: 'em-curso', order: 2),
    MilestoneData(id: 'm3', label: 'Design final + handoff', amount: 128000, dueDate: '30 Mai', status: 'pendente', order: 3),
  ],
  'co2': [
    MilestoneData(id: 'm4', label: 'Setup do projecto', amount: 56000, dueDate: '15 Abr', status: 'concluido', order: 1),
    MilestoneData(id: 'm5', label: 'Sprint 1 — autenticação', amount: 84000, dueDate: '25 Abr', status: 'concluido', order: 2),
    MilestoneData(id: 'm6', label: 'Sprint 2 — dashboards', amount: 84000, dueDate: '08 Mai', status: 'em-curso', order: 3),
    MilestoneData(id: 'm7', label: 'Entrega final + QA', amount: 56000, dueDate: '20 Mai', status: 'pendente', order: 4),
  ],
  'co3': [
    MilestoneData(id: 'm8', label: 'Tradução completa', amount: 45000, dueDate: '20 Abr', status: 'concluido', order: 1),
  ],
  'co4': [
    MilestoneData(id: 'm9', label: 'Recolha de documentos', amount: 30000, dueDate: '30 Abr', status: 'pendente', order: 1),
    MilestoneData(id: 'm10', label: 'Auditoria + relatório', amount: 60000, dueDate: '15 Mai', status: 'pendente', order: 2),
  ],
};

// ──────────────────────────────────────────────────────────────────────────
// Categories for portfolio (used in add_portfolio_item)
// ──────────────────────────────────────────────────────────────────────────
const portfolioCategories = <String>[
  'Fintech', 'Agritech', 'Branding', 'Design System', 'EdTech', 'Marketing', 'Mobile', 'Web', 'E-commerce', 'Sem categoria',
];

const portfolioCovers = <Color>[
  LinkUpColors.green, LinkUpColors.greenDark, LinkUpColors.gold, LinkUpColors.navy, LinkUpColors.cream, Color(0xFFE8ECF1),
];
