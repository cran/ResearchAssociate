#' Plot Top cited publications from data returned by "Get.Publication.info" Function
#'
#' @usage Plot.TopPapers(Publications, Top = 10, directorypath  = NULL)
#'
#' @param Publications Dataframe returned by "Get.Publication.info" Function.
#'
#' @param Top Number of publications to be visulaized sorted by citations.
#'
#' @param directorypath path to save plot generated by the function.
#'
#' @author Mohmed Soudy \email{Mohamed.soudy@57357.com} and Ali Mostafa \email{ali.mo.anwar@std.agr.cu.edu.eg}
#'
#' @export
#'
Plot.TopPapers <- function(Publications, Top = 10, directorypath  = NULL)
{
  Sorted.Publications <- Publications[order(Publications$pmcrefcount, decreasing = T),]
  if (dim(Sorted.Publications)[1] < Top)
    Top <- dim(Sorted.Publications)[1]

  Sorted.Publications <- Sorted.Publications[1:Top,]

  CitationCount <- as.numeric(Sorted.Publications$pmcrefcount)
  TopCited <- ggplot(Sorted.Publications, aes(x = reorder(Sorted.Publications$title, -CitationCount), y = CitationCount)) +
    geom_bar(stat="identity", fill="steelblue") + geom_text(aes(label=CitationCount),
                                                            hjust=-0.5, color="steelblue", size=5) + xlab("") +
    ylab("Number of citations") + theme_classic() + theme(axis.text.x = element_text(face = "bold.italic", size = 0.5, hjust = 1)) +
    coord_flip()
  plot(TopCited)
  if(!is.null(directorypath))
  {
    ggsave(plot = TopCited, filename = paste0(directorypath, "/", "Top ", Top, " Cited papers.jpeg"),device = "jpeg" ,width = 21, height = 10, dpi = 300)
  }
}
#' Plot Top cited Journals from data returned by "Get.Publication.info" Function
#'
#' @usage Plot.TopJournals(Publications, Top = 10, directorypath  = NULL)
#'
#' @param Publications Dataframe returned by "Get.Publication.info" Function.
#'
#' @param Top Number of Journals to be visulaized sorted by citations.
#'
#' @param directorypath path to save plot generated by the function.
#'
#' @author Mohmed Soudy \email{Mohamed.soudy@57357.com} and Ali Mostafa \email{ali.mo.anwar@std.agr.cu.edu.eg}
#'
#' @export
Plot.TopJournals <- function(Publications, Top = 10, directorypath  = NULL)
{
  Publications$pmcrefcount <- as.numeric(Publications$pmcrefcount)
  Top.Cited.Journals <- setNames(aggregate(Publications$pmcrefcount, by = list(Publications$source), sum, na.rm = T),
                                 c("Journal", "Number of citations"))

  Top.Cited.Journals <- Top.Cited.Journals[order(Top.Cited.Journals$`Number of citations`, decreasing = T),][1:Top,]

  Top.cited <- ggplot(data = Top.Cited.Journals, aes(x = reorder(Top.Cited.Journals$Journal, -Top.Cited.Journals$`Number of citations`),
                                                y = Top.Cited.Journals$`Number of citations`)) +
    geom_bar(stat="identity", fill="steelblue") + geom_text(aes(label=Top.Cited.Journals$`Number of citations`),
                                                            vjust=-1, color="steelblue", size=3.5) + xlab("Journal") +
    ylab("Number of citations") + theme_classic() + theme(axis.text.x = element_text(angle = 45, hjust = 1))

  plot(Top.cited)
  if(!is.null(directorypath))
  {
    ggsave(plot = Top.cited, filename = paste0(directorypath, "/", "Top ", Top, " Cited journals.jpeg"),device = "jpeg" ,width = 8, height = 7, dpi = 300)
  }
}
#' Plot papers type returned by "Get.Publication.info" Function
#'
#' @usage Plot.papertype(Publications, directorypath  = NULL)
#'
#' @param Publications Dataframe returned by "Get.Publication.info" Function.
#'
#' @param directorypath path to save plot generated by the function.
#'
#' @author Mohmed Soudy \email{Mohamed.soudy@57357.com} and Ali Mostafa \email{ali.mo.anwar@std.agr.cu.edu.eg}
#'
#' @export
Plot.papertype <- function(Publications, directorypath = NULL)
{
  Publication.type <- setNames(count(Publications$pubtype),
                                 c("Pubtype", "Number of publications"))

  Pub.type <- ggplot(data = Publication.type, aes(x = reorder(Publication.type$Pubtype, -Publication.type$`Number of publications`),
                                                     y = Publication.type$`Number of publications`)) +
    geom_bar(stat="identity", fill="steelblue") + geom_text(aes(label=Publication.type$`Number of publications`),
                                                            vjust=-1, color="steelblue", size=3.5) + xlab("Publication type") +
    ylab("Number of publications") + theme_classic() + theme(axis.text.x = element_text(angle = 45, hjust = 1))

  plot(Pub.type)

  if(!is.null(directorypath))
  {
    ggsave(plot = Pub.type, filename = paste0(directorypath, "/", "Publication type.jpeg"),device = "jpeg" ,width = 4, height = 6, dpi = 300)
  }
}
