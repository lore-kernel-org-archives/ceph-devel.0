From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: weighted distributed processing.
Date: Wed, 2 May 2012 16:30:47 -0700
Message-ID: <A72DA5A486E84E958B7F6F458973E897@dreamhost.com>
References: <4FA18F2D.3020007@usask.ca> <4FA1AFA3.9000300@artefactual.com>
 <1335996860-sup-4969@fewbar.com>
 <E6D5F699883B445BB45DEC9D2EE16EC7@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54722 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab2EBXau convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 May 2012 19:30:50 -0400
Received: by obbtb18 with SMTP id tb18so1624642obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 May 2012 16:30:50 -0700 (PDT)
In-Reply-To: <E6D5F699883B445BB45DEC9D2EE16EC7@dreamhost.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joseph Perry <joseph@artefactual.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

(Trimmed CC:) apparently neither Gearman nor Archivematica lists allow =
posting from non-members, which leads to some wonderful spam from Googl=
e and is going to make holding a cross-list conversation=E2=80=A6diffic=
ult. =20


On Wednesday, May 2, 2012 at 4:26 PM, Greg Farnum wrote:

> =20
> =20
> On Wednesday, May 2, 2012 at 3:42 PM, Clint Byrum wrote:
> =20
> > Excerpts from Joseph Perry's message of Wed May 02 15:05:23 -0700 2=
012:
> > > Hello All,
> > > First off, I'm sending this email to three discussion groups:
> > > gearman@googlegroups.com (mailto:gearman@googlegroups.com) - dist=
ributed processing library
> > > ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org) - =
distributed file system
> > > archivematica@googlegroups.com (mailto:archivematica@googlegroups=
=2Ecom) - my project's discussion list, a =20
> > > distributed processing system.
> > > =20
> > > I'd like to start a discussion about something I'll refer to as w=
eighted =20
> > > distributed task based processing.
> > > Presently, we are using gearman's library's to meet our distribut=
ed =20
> > > processing needs. The majority of our processing is file based, a=
nd our =20
> > > processing stations are accessing the files over an nfs share. We=
 are =20
> > > looking at replacing the nfs server share with a distributed file=
 =20
> > > systems, like ceph.
> > > =20
> > > It occurs to me that our processing times could theoretically be =
reduced =20
> > > by by assigning tasks to processing clients where the file reside=
s, over =20
> > > places where it would need to be copied over the network. In orde=
r for =20
> > > this to happen, the gearman server would need to get file locatio=
n =20
> > > information from the ceph system.
> > =20
> > =20
> > =20
> > =20
> > =20
> > If I understand the design of CEPH completely, it spreads I/O at th=
e
> > block level, not the file level.
> > =20
> > So there is little point in weighting since it seeks to spread the =
whole
> > file across all the machines/block devices in the cluster. Even if =
you
> > do ask ceph "which servers is file X on", which I'm sure it could t=
ell
> > you, You will end up with high weights for most of the servers, and=
 no
> > real benefit.
> > =20
> > In this scenario, you're just better off having a really powerful n=
etwork
> > and CEPH will balance the I/O enough that you can scale out the I/O
> > independently of the compute resources. This seems like a huge win,=
 as
> > I don't believe most workloads scale at a 1:1 I/O:CPU ratio. 10Giga=
bit
> > switches are still not super cheap, but they are probably cheaper t=
han
> > software engineer hours.
> > =20
> > If your network is not up to the task of transferring all those blo=
cks
> > around, you probably need to focus instead on something that keeps =
whole
> > files in a certain place. One such system would be MogileFS. This h=
as a
> > database with a list of keys that say where the data lives, and in =
fact
> > the protocol the MogileFS tracker uses will tell you all the places=
 a
> > key lives. You could then place a hint in the payload and have 2 le=
vels
> > of workers. The pseudo becomes:
> > =20
> > -workers register two queues. 'dispatch_foo', and 'do_foo_$hostname=
'
> > -client sends task w/ filename to 'dispatch_foo' =20
> > -dispatcher looks at filename, asks mogile where the file is, looks=
 at
> > recent queue lengths in gearman, and decides whether or not it is e=
nough
> > of a win to direct the job to the host where the file is, or to far=
m it
> > out to somewhere that is less busy.
> > =20
> > This will take a lot of poking at to get tuned right, but it should=
 be
> > tunable to a single number, the ratio of localized queue length ver=
sus
> > non-localized queue length.
> > =20
> > > pseudo:
> > > gearman client creates a task & includes a weight, of type ceph f=
ile
> > > gearman server identifies the file & polls the ceph system for cl=
ients =20
> > > that have this file
> > > ceph system returns a list of clients that have the file locally
> > > gearman assigns the task
> > > . if there is a client available for processing that has the file=
 locally
> > > . assign it there
> > > . (that client has local access to the file, still on the ceph =20
> > > system)
> > > . else
> > > . assign to other client
> > > . (that processing client will pull the file from the ceph system=
 =20
> > > over the network)
> > > =20
> > > =20
> > > I call it a weighted distributed processing system, because it re=
minds =20
> > > me of a weighted die: The outcome is influenced to a certain dire=
ction =20
> > > (in the task assignment).
> > > =20
> > > I wanted to start this as a discussion, rather than filing featur=
e =20
> > > requests, because of the complex nature of the requests, and the =
nicer =20
> > > medium for feedback, clarification and refinement.
> > > =20
> > > I'd be very interested to hear feedback on the idea,
> > > Joseph Perry
> > =20
> =20
> =20
> =20
> https://groups.google.com/group/gearman/browse_thread/thread/12a1b3aa=
64f103d1
> ^ is the Google Groups link for this (ceph-devel doesn't seem to have=
 gotten the original email =E2=80=94 at least I didn't!).
> =20
> Clint is mostly correct: Ceph does not store files in a single locati=
on. It's not block-based in the sense of 4K disk blocks though =E2=80=94=
 instead it breaks up files into (by default) 4MB chunks. It's possible=
 to change this default to a larger number though; our Hadoop bindings =
break files into 64MB chunks. And it is possible to retrieve this locat=
ion data using the cephfs tool:
> ./cephfs =20
> not enough parameters!
> usage: cephfs path command [options]*
> Commands:
> show_layout -- view the layout information on a file or dir
> set_layout -- set the layout on an empty file,
> or the default layout on a directory
> show_location -- view the location information on a file
> Options:
> Useful for setting layouts:
> --stripe_unit, -u: set the size of each stripe
> --stripe_count, -c: set the number of objects to stripe across
> --object_size, -s: set the size of the objects to stripe across
> --pool, -p: set the pool to use
> Useful for getting location data:
> --offset, -l: the offset to retrieve location data for
> =20
> =20
> =20
> I suspect this provides the information you're looking for?
> =20
> -Greg =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
