From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: efficient removal of old objects
Date: Wed, 1 Feb 2012 00:04:38 -0800
Message-ID: <CAC-hyiFWUr6srUDk2mm2YrCrGjO90rfy5VYXBoRaDQuWp4TDsw@mail.gmail.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
	<CAORUGqCkRzAbXVjGvVDGX=MxURMy5NijsdPGRgWDpgT3_CyMow@mail.gmail.com>
	<CAC-hyiExnN6CxMh=+5tLoZy3T0=Mx6Y3P796rG3L01mZ-=+vOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62151 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab2BAIEi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 03:04:38 -0500
Received: by ggnh1 with SMTP id h1so436922ggn.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2012 00:04:38 -0800 (PST)
In-Reply-To: <CAC-hyiExnN6CxMh=+5tLoZy3T0=Mx6Y3P796rG3L01mZ-=+vOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(resending to list, sorry tv)

On Tue, Jan 31, 2012 at 5:02 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
>
> On Tue, Jan 31, 2012 at 16:33, Sage Weil <sage@newdream.net> wrote:
> > Currently rgw logs objects it wants to delete after some period of =
time,
> > and an radosgw-admin command comes back later to process the log. =A0=
It
> > works, but is currently slow (one sync op at a time).
> >
> > A better approach would be to mark objects for later removal, and h=
ave the
> > OSD do it in some more efficient way. =A0wip-objs-expire has a clie=
nt side
> > (librados) interface for this.
>
> Is there some reason why this would be significantly more performant
> when done by the OSD itself? It seems like the deletion times can be
> bucketed by time nicely, then each bucket just contains a set of ids
> -- a good fit for the map data type -- and the client for running thi=
s
> deletion just streams the bucket contents over and issues delete
> messages for everything. What makes that inherently slow?

Random access to random cold objects is generally slower than doing
the operations on a single pg. E.g., if doing it as part of the scrub,
then objects are accessed anyway and are hopefully cached.

>
> > Should this be generalized to saying "do these osd ops at time X" i=
nstead
> > of "delete at time X". =A0Then it could setxattr, remove, call into=
 a class,
> > whatever.
>
> That sounds like a really complex API, for quite marginal gain.

I do agree that for the sake of a garbage collection it's an overkill, =
however,

>
> To make my point even clearer: point me to another data store that ha=
s
> that idiom.

I can see its use, and even if not, I'm sure that there would be users
who would need it. I don't think there's any relevance to the question
whether there's any data store that implements that.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
