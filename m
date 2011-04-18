From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH 2/4] config: Update sample configuration to new naming
 scheme
Date: Mon, 18 Apr 2011 09:01:51 +0200
Message-ID: <1303110111.5322.223.camel@wido-laptop.pcextreme.nl>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
	 <1303032724-13456-2-git-send-email-wido@widodh.nl>
	 <BANLkTikdn5JmByEum8Phz_0nK0G7f5W7vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52044 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab1DRHBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 03:01:54 -0400
In-Reply-To: <BANLkTikdn5JmByEum8Phz_0nK0G7f5W7vQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

Hi,

On Sun, 2011-04-17 at 17:37 -0700, Colin McCabe wrote:
> I don't think we want log to syslog to be in the sample configuration
> file. Maybe we could include it, but commented out. Most users will
> want to enable logging to a file or to syslog, but not both.
> 

Ah yes, I see. The syslog was my bad, my idea was to have it commented
out, but have it just as a reference in there, didn't check that good
enough.

But right now you can only disable logging to a file by setting:

log file = 

That seems a bit odd, "log file = false" would be easier.

Imho the current sample config is still broken.

Monitors names are only numeric, shouldn't we encourage users to give
them a full name? mon.alpha, mon.beta, etc?

osd journal = /data/osd$id/journal

That will result in: /data/osd0/journal

When the osd's name is osd.0, that also seems a bit weird, would $name
be better there then osd$id (see my patch).

Same goes for data btw

Wido

> Colin
> 
> 
> On Sun, Apr 17, 2011 at 2:32 AM, Wido den Hollander <wido@widodh.nl> wrote:
> >
> > Signed-off-by: Wido den Hollander <wido@widodh.nl>
> > ---
> >  src/sample.ceph.conf |   23 +++++++++++++----------
> >  1 files changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
> > index bb874e7..31674f6 100644
> > --- a/src/sample.ceph.conf
> > +++ b/src/sample.ceph.conf
> > @@ -24,6 +24,9 @@
> >         ; set up pid files
> >         pid file = /var/run/ceph/$name.pid
> >
> > +        ; Also log to syslog
> > +        log to syslog = true
> > +
> >  ; monitors
> >  ;  You need at least one.  You need at least three if you want to
> >  ;  tolerate any node failures.  Always create an odd number.
> > @@ -37,15 +40,15 @@
> >        ;debug paxos = 20
> >        ;debug auth = 20
> >
> > -[mon0]
> > +[mon.alpha]
> >        host = alpha
> >        mon addr = 192.168.0.10:6789
> >
> > -[mon1]
> > +[mon.beta]
> >        host = beta
> >        mon addr = 192.168.0.11:6789
> >
> > -[mon2]
> > +[mon.gamma]
> >        host = gamma
> >        mon addr = 192.168.0.12:6789
> >
> > @@ -70,16 +73,16 @@
> >  ;  Define as many as you like.
> >  [osd]
> >        ; This is where the btrfs volume will be mounted.
> > -       osd data = /data/osd$id
> > +       osd data = /data/$name
> >
> >        ; Ideally, make this a separate disk or partition.  A few
> >        ; hundred MB should be enough; more if you have fast or many
> >        ; disks.  You can use a file under the osd data dir if need be
> > -       ; (e.g. /data/osd$id/journal), but it will be slower than a
> > +       ; (e.g. /data/$name/journal), but it will be slower than a
> >        ; separate disk or partition.
> >
> >         ; This is an example of a file-based journal.
> > -       osd journal = /data/osd$id/journal
> > +       osd journal = /data/$name/journal
> >        osd journal size = 1000 ; journal size, in megabytes
> >
> >        ; osd logging to debug osd issues, in order of likelihood of being
> > @@ -89,7 +92,7 @@
> >        ;debug filestore = 20
> >        ;debug journal = 20
> >
> > -[osd0]
> > +[osd.0]
> >        host = delta
> >
> >        ; if 'btrfs devs' is not specified, you're responsible for
> > @@ -98,14 +101,14 @@
> >        ; usually fine for basic testing).
> >        btrfs devs = /dev/sdx
> >
> > -[osd1]
> > +[osd.1]
> >        host = epsilon
> >        btrfs devs = /dev/sdy
> >
> > -[osd2]
> > +[osd.2]
> >        host = zeta
> >        btrfs devs = /dev/sdx
> >
> > -[osd3]
> > +[osd.3]
> >        host = eta
> >        btrfs devs = /dev/sdy
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


