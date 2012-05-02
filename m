From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: weighted distributed processing.
Date: Wed, 2 May 2012 16:26:40 -0700
Message-ID: <E6D5F699883B445BB45DEC9D2EE16EC7@dreamhost.com>
References: <4FA18F2D.3020007@usask.ca> <4FA1AFA3.9000300@artefactual.com>
 <1335996860-sup-4969@fewbar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42706 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751208Ab2EBX0n convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 May 2012 19:26:43 -0400
Received: by ghrr11 with SMTP id r11so1286704ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 May 2012 16:26:42 -0700 (PDT)
In-Reply-To: <1335996860-sup-4969@fewbar.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Clint Byrum <clint@fewbar.com>
Cc: Joseph Perry <joseph@artefactual.com>, archivematica <archivematica@googlegroups.com>, gearman <gearman@googlegroups.com>, ceph-devel <ceph-devel@vger.kernel.org>



On Wednesday, May 2, 2012 at 3:42 PM, Clint Byrum wrote:

> Excerpts from Joseph Perry's message of Wed May 02 15:05:23 -0700 201=
2:
> > Hello All,
> > First off, I'm sending this email to three discussion groups:
> > gearman@googlegroups.com (mailto:gearman@googlegroups.com) - distri=
buted processing library
> > ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org) - di=
stributed file system
> > archivematica@googlegroups.com (mailto:archivematica@googlegroups.c=
om) - my project's discussion list, a =20
> > distributed processing system.
> > =20
> > I'd like to start a discussion about something I'll refer to as wei=
ghted =20
> > distributed task based processing.
> > Presently, we are using gearman's library's to meet our distributed=
 =20
> > processing needs. The majority of our processing is file based, and=
 our =20
> > processing stations are accessing the files over an nfs share. We a=
re =20
> > looking at replacing the nfs server share with a distributed file =20
> > systems, like ceph.
> > =20
> > It occurs to me that our processing times could theoretically be re=
duced =20
> > by by assigning tasks to processing clients where the file resides,=
 over =20
> > places where it would need to be copied over the network. In order =
for =20
> > this to happen, the gearman server would need to get file location =
=20
> > information from the ceph system.
> =20
> =20
> =20
> If I understand the design of CEPH completely, it spreads I/O at the
> block level, not the file level.
> =20
> So there is little point in weighting since it seeks to spread the wh=
ole
> file across all the machines/block devices in the cluster. Even if yo=
u
> do ask ceph "which servers is file X on", which I'm sure it could tel=
l
> you, You will end up with high weights for most of the servers, and n=
o
> real benefit.
> =20
> In this scenario, you're just better off having a really powerful net=
work
> and CEPH will balance the I/O enough that you can scale out the I/O
> independently of the compute resources. This seems like a huge win, a=
s
> I don't believe most workloads scale at a 1:1 I/O:CPU ratio. 10Gigabi=
t
> switches are still not super cheap, but they are probably cheaper tha=
n
> software engineer hours.
> =20
> If your network is not up to the task of transferring all those block=
s
> around, you probably need to focus instead on something that keeps wh=
ole
> files in a certain place. One such system would be MogileFS. This has=
 a
> database with a list of keys that say where the data lives, and in fa=
ct
> the protocol the MogileFS tracker uses will tell you all the places a
> key lives. You could then place a hint in the payload and have 2 leve=
ls
> of workers. The pseudo becomes:
> =20
> -workers register two queues. 'dispatch_foo', and 'do_foo_$hostname'
> -client sends task w/ filename to 'dispatch_foo' =20
> -dispatcher looks at filename, asks mogile where the file is, looks a=
t
> recent queue lengths in gearman, and decides whether or not it is eno=
ugh
> of a win to direct the job to the host where the file is, or to farm =
it
> out to somewhere that is less busy.
> =20
> This will take a lot of poking at to get tuned right, but it should b=
e
> tunable to a single number, the ratio of localized queue length versu=
s
> non-localized queue length.
> =20
> > pseudo:
> > gearman client creates a task & includes a weight, of type ceph fil=
e
> > gearman server identifies the file & polls the ceph system for clie=
nts =20
> > that have this file
> > ceph system returns a list of clients that have the file locally
> > gearman assigns the task
> > . if there is a client available for processing that has the file l=
ocally
> > . assign it there
> > . (that client has local access to the file, still on the ceph =20
> > system)
> > . else
> > . assign to other client
> > . (that processing client will pull the file from the ceph system =20
> > over the network)
> > =20
> > =20
> > I call it a weighted distributed processing system, because it remi=
nds =20
> > me of a weighted die: The outcome is influenced to a certain direct=
ion =20
> > (in the task assignment).
> > =20
> > I wanted to start this as a discussion, rather than filing feature =
=20
> > requests, because of the complex nature of the requests, and the ni=
cer =20
> > medium for feedback, clarification and refinement.
> > =20
> > I'd be very interested to hear feedback on the idea,
> > Joseph Perry
> =20

https://groups.google.com/group/gearman/browse_thread/thread/12a1b3aa64=
f103d1
^ is the Google Groups link for this (ceph-devel doesn't seem to have g=
otten the original email =E2=80=94 at least I didn't!).

Clint is mostly correct: Ceph does not store files in a single location=
=2E It's not block-based in the sense of 4K disk blocks though =E2=80=94=
 instead it breaks up files into (by default) 4MB chunks. It's possible=
 to change this default to a larger number though; our Hadoop bindings =
break files into 64MB chunks. And it is possible to retrieve this locat=
ion data using the cephfs tool:
=2E/cephfs =20
not enough parameters!
usage: cephfs path command [options]*
Commands:
show_layout -- view the layout information on a file or dir
set_layout -- set the layout on an empty file,
or the default layout on a directory
show_location -- view the location information on a file
Options:
Useful for setting layouts:
--stripe_unit, -u: set the size of each stripe
--stripe_count, -c: set the number of objects to stripe across
--object_size, -s: set the size of the objects to stripe across
--pool, -p: set the pool to use
Useful for getting location data:
--offset, -l: the offset to retrieve location data for



I suspect this provides the information you're looking for?

-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
