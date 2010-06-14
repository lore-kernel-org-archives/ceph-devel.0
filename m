From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: minor file journal size bug
Date: Mon, 14 Jun 2010 10:37:53 -0700
Message-ID: <AANLkTimuybE0Lw-2RC2VOAUKh5OWopXcp4f3fdfYs2xv@mail.gmail.com>
References: <4C163A7E.6060701@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52125 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab0FNRhy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jun 2010 13:37:54 -0400
Received: by vws13 with SMTP id 13so32408vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jun 2010 10:37:53 -0700 (PDT)
In-Reply-To: <4C163A7E.6060701@mcs.anl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Phil Carns <carns@mcs.anl.gov>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 14, 2010 at 7:19 AM, Phil Carns <carns@mcs.anl.gov> wrote:
> Hi,
>
> I ran into a minor problem when configuring the ObjectStore to use a =
file
> journal that was 10 gigabytes in size (osd_journal_size =3D 10240). =A0=
The
> osd_journal_size configuration parameter is an integer. =A0This would=
 normally
> be fine since the units are in megabytes, but it can overflow when bi=
t
> shifted in FileJournal.cc. =A0This causes the journal to fall back to=
 trying
> to detect a raw block device journal.
>
> I've attached a small patch that fixes the problem for me, but there =
is
> probably a cleaner way to do it.
>

Thanks!

Just defining osd_journal_size as a long long would do the trick (as
follows), although I'm not sure whether we need to be able to define
journals that are bigger than 2^32 MB. So I guess that in this case we
should probably go with your solution, and also go over the code and
check to see whether we have some other places where we do the same.
We should really be using some macro that does this conversion with a
correct cast.

Yehuda

diff --git a/src/config.cc b/src/config.cc
index 9615186..bb4e2c9 100644
--- a/src/config.cc
+++ b/src/config.cc
@@ -431,7 +431,7 @@ static struct config_option config_optionsp[] =3D {
        OPTION(mds_kill_import_at, 0, OPT_INT, 0),
        OPTION(osd_data, 0, OPT_STR, ""),
        OPTION(osd_journal, 0, OPT_STR, ""),
-       OPTION(osd_journal_size, 0, OPT_INT, 0),         // in mb
+       OPTION(osd_journal_size, 0, OPT_LONGLONG, 0),         // in mb
        OPTION(osd_balance_reads, 0, OPT_BOOL, false),
        OPTION(osd_flash_crowd_iat_threshold, 0, OPT_INT, 0),
        OPTION(osd_flash_crowd_iat_alpha, 0, OPT_DOUBLE, 0.125),
diff --git a/src/config.h b/src/config.h
index 68dca6f..45206f6 100644
--- a/src/config.h
+++ b/src/config.h
@@ -290,7 +290,7 @@ struct md_config_t {
   // osd
   const char *osd_data;
   const char *osd_journal;
-  int osd_journal_size;  // in mb
+  long long osd_journal_size;  // in mb
   bool osd_balance_reads;
   int osd_flash_crowd_iat_threshold;  // flash crowd interarrival
time threshold in ms
   double osd_flash_crowd_iat_alpha;
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
