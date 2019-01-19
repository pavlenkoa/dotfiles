diff --git a/suckless/dwm/dwm.c b/suckless/dwm/dwm.c
--- a/suckless/dwm/dwm.c
+++ b/suckless/dwm/dwm.c
@@ -746,6 +746,12 @@ drawbar(Monitor *m)
     int tx = 0;
     char ctmp;
 	Client *c;
+  int correct = 0; /* correction for colours */
+
+  for ( ; *ts != '\0' ; ts++)
+    if (*ts < LENGTH(colors))
+      correct += TEXTW("A") - lrpad;
+  ts = stext;
 
 	/* draw status first so it can be overdrawn by tags later */
 	if (m == selmon) { /* status is only drawn on selected monitor */
@@ -755,7 +761,7 @@ drawbar(Monitor *m)
 			if ((unsigned int)*ts > LENGTH(colors)) { ts++; continue ; }
 			ctmp = *ts;
 			*ts = '\0';
-			drw_text(drw, m->ww - sw + tx, 0, sw - tx, bh, 0, tp, 0);
+			drw_text(drw, m->ww - sw + tx + correct, 0, sw - tx - correct, bh, 0, tp, 0);
 			tx += TEXTW(tp) -lrpad;
 			if (ctmp == '\0') { break; }
 			drw_setscheme(drw, scheme[(unsigned int)(ctmp-1)]);