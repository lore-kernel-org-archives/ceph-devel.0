From: Sage Weil <sage@newdream.net>
Subject: Re: Question about Logging Level
Date: Thu, 12 Jan 2017 13:41:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701121338090.5745@piezo.novalocal>
References: <CACKY0b-_ZaLCVUwdW4-p6BtPeaAHQ10B-KqjmxuM+Nh5h_xj5A@mail.gmail.com> <CALe9h7eF77h5RA8UYGv6ryC5rLwHJewZjVf8d_eKqNoMnPg6wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-477244741-1484228484=:5745"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48712 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750843AbdALNmM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 08:42:12 -0500
In-Reply-To: <CALe9h7eF77h5RA8UYGv6ryC5rLwHJewZjVf8d_eKqNoMnPg6wQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: liuchang0812 <liuchang0812@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-477244741-1484228484=:5745
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2017, John Spray wrote:
> On Thu, Jan 12, 2017 at 8:12 AM, liuchang0812 <liuchang0812@gmail.com> wrote:
> > Hi, all
> >
> > In our documentation, it says that:
> >
> >         Ceph’s logging levels operate on a scale of 1 to 20, where 1
> > is terse and 20 is verbose.
> >
> > http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/#subsystem-log-and-debug-settings
> >
> >
> > But, it seems that there are some logging levels 25 :
> >
> >
> > mds/MDBalancer.cc:276:  dout(25) << "=== got heartbeat " <<
> > m->get_beat() << " from " << m->get_source().num() << " " <<
> > m->get_load() << dendl;
> > mds/CInode.cc:4189:  dout(25) << __func__ << dendl;
> > mds/MDCache.cc:11656:    //dout(25) << "saw depth " << d << " " <<
> > *dir << dendl;
> > mds/MDCache.cc:11666:   //dout(25) << " saw sub " << **p << dendl;
> > mds/journal.cc:373:      dout(25) << "EMetaBlob::add_dir_context(" <<
> > dir << ")      maybe " <<
> >
> >
> > So, shoud we update our documentation, or update logging level to 20?
> 
> Probably neither -- the >20 log messages are intentionally obscure
> things (although I do accept that there is a reasonable argument that
> if we would never turn something on in a real system then we perhaps
> should not have it in the code...)

FWIW, the guideline I tend to use:

 10 - O(requests)
 20 - O(requests) or O(internal structures).  e.g., we dump pg log entries 
and dump every element other ptoential large data structures at 20
 30 - O(bytes).  several bits of code hexdump actual read/write data at 
30)

You could update the doc to mention that there are levels >20 in some rare 
cases and that they are extremely verbose.

sage
--8323329-477244741-1484228484=:5745--
