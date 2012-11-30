From: Sage Weil <sage@inktank.com>
Subject: Re: OSD daemon changes port no
Date: Fri, 30 Nov 2012 08:34:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211300831310.3173@cobra.newdream.net>
References: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com> <alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net> <CAGfy=6k3xh_dKJRNiNL_ecKOOXnGWaQT5i2K0Gpz9wW0=C7mWg@mail.gmail.com> <alpine.DEB.2.00.1211202217320.1082@cobra.newdream.net>
 <CAGfy=6=7xGcuaDnB72Lp9mey_esU015wCyiTZKPHwEFw=pEuyQ@mail.gmail.com> <alpine.DEB.2.00.1211202302390.1082@cobra.newdream.net> <CAGfy=6mL5UAeO9EM7VD4BbRRYy2eC8C1HLMu3vvyizYD43NiGw@mail.gmail.com> <alpine.DEB.2.00.1211210726110.1082@cobra.newdream.net>
 <CAGfy=6kAkXrdYwL-Ui-Xd2Qsqaf8hcUbWGY94QOFfaRA1AmUrA@mail.gmail.com> <alpine.DEB.2.00.1211260826190.23552@cobra.newdream.net> <CAGfy=6mOnv90GighPr=nTWapJU_4wjo-z9nHh_ji6VvvrUeMHg@mail.gmail.com> <alpine.DEB.2.00.1211270851320.30109@cobra.newdream.net>
 <CAGfy=6mNa02BE6vsRssx6qURxCy9TtnXShxaS0PMPcepnuARvQ@mail.gmail.com> <CAGfy=6mDnVDTSNFD5R-iXz1cPAty1FmXa7fX6K1kA9UqAWJvCg@mail.gmail.com> <CAGfy=6kNPEiUSByW7Bo6CMgttXdZSdYR5ESajXWxEW30+qyhPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42997 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758620Ab2K3QeV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 11:34:21 -0500
In-Reply-To: <CAGfy=6kNPEiUSByW7Bo6CMgttXdZSdYR5ESajXWxEW30+qyhPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

What kernel version and mds version are you running?  I did

# ceph osd pool create foo 12
# ceph osd pool create bar 12
# ceph mds add_data_pool 3
# ceph mds add_data_pool 4

and from a kernel mount

# mkdir foo
# mkdir bar
# cephfs foo set_layout --pool 3
# cephfs bar set_layout --pool 4
# cephfs foo show_layout
layout.data_pool:     3
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1
# cephfs bar show_layout 
layout.data_pool:     4
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1

This much you can test without playing with the crush map, btw.

Maybe there is some crazy bug when the set_layouts are pipelined?  Try 
with out using & ?

sage


On Fri, 30 Nov 2012, hemant surale wrote:

> Hi Sage,Community ,
>    I am unable to use 2 directories to direct data to 2 different
> pools. I did following expt.
> 
> Created 2 pool "host" & "ghost" to seperate data placement .
> --------------------------------------------------//crushmap file
> -------------------------------------------------------
> # begin crush map
> 
> # devices
> device 0 osd.0
> device 1 osd.1
> device 2 osd.2
> device 3 osd.3
> 
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 row
> type 4 room
> type 5 datacenter
> type 6 pool
> type 7 ghost
> 
> # buckets
> host hemantone-mirror-virtual-machine {
>         id -6           # do not change unnecessarily
>         # weight 1.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.2 weight 1.000
> }
> host hemantone-virtual-machine {
>         id -7           # do not change unnecessarily
>         # weight 1.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.1 weight 1.000
> }
> rack one {
>         id -2           # do not change unnecessarily
>         # weight 2.000
>         alg straw
>         hash 0  # rjenkins1
>         item hemantone-mirror-virtual-machine weight 1.000
>         item hemantone-virtual-machine weight 1.000
> }
> ghost hemant-virtual-machine {
>         id -4           # do not change unnecessarily
>         # weight 1.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.0 weight 1.000
> }
> ghost hemant-mirror-virtual-machine {
>         id -5           # do not change unnecessarily
>         # weight 1.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.3 weight 1.000
> }
> rack two {
>         id -3           # do not change unnecessarily
>         # weight 2.000
>         alg straw
>         hash 0  # rjenkins1
>         item hemant-virtual-machine weight 1.000
>         item hemant-mirror-virtual-machine weight 1.000
> }
> pool default {
>         id -1           # do not change unnecessarily
>         # weight 4.000
>         alg straw
>         hash 0  # rjenkins1
>         item one weight 2.000
>         item two weight 2.000
> }
> 
> # rules
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step take one
>         step chooseleaf firstn 0 type host
>         step emit
> }
> rule metadata {
>         ruleset 1
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step take one
>         step chooseleaf firstn 0 type host
>         step emit
> }
> rule rbd {
>         ruleset 2
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step take one
>         step chooseleaf firstn 0 type host
>         step emit
> }
> rule forhost {
>         ruleset 3
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step take one
>         step chooseleaf firstn 0 type host
>         step emit
> }
> rule forghost {
>         ruleset 4
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step take two
>         step chooseleaf firstn 0 type ghost
>         step emit
> }
> 
> # end crush map
> ------------------------------------------------------------------------------------------------------------------------
> 1) set replication factor to 2. and crushrule accordingly . ( "host"
> got crush_ruleset = 3 & "ghost" pool got  crush_ruleset = 4).
> 2) Now I mounted data to dir.  using "mount.ceph 10.72.148.245:6789:/
> /home/hemant/x"   & "mount.ceph 10.72.148.245:6789:/ /home/hemant/y"
> 3) then "mds add_data_pool 5"  & "mds add_data_pool 6"  ( here pool id
> are host = 5, ghost = 6)
> 4) "cephfs /home/hemant/x set_layout --pool 5 -c 1 -u 4194304 -s
> 4194304"  & "cephfs /home/hemant/y set_layout --pool 6 -c 1 -u 4194304
> -s 4194304"
> 
> PROBLEM:
>  $ cephfs /home/hemant/x show_layout
> layout.data_pool:     6
> layout.object_size:   4194304
> layout.stripe_unit:   4194304
> layout.stripe_count:  1
> cephfs /home/hemant/y show_layout
> layout.data_pool:     6
> layout.object_size:   4194304
> layout.stripe_unit:   4194304
> layout.stripe_count:  1
> 
> Both dir are using same pool to place data even after I specified to
> use separate using "cephfs" cmd.
> Please help me figure this out.
> 
> -
> Hemant Surale.
> 
> 
> On Thu, Nov 29, 2012 at 3:45 PM, hemant surale <hemant.surale@gmail.com> wrote:
> >>> does 'ceph mds dump' list pool 3 in teh data_pools line?
> >
> > Yes. It lists the desired poolids I wanted to put data in.
> >
> >
> > ---------- Forwarded message ----------
> > From: hemant surale <hemant.surale@gmail.com>
> > Date: Thu, Nov 29, 2012 at 2:59 PM
> > Subject: Re: OSD daemon changes port no
> > To: Sage Weil <sage@inktank.com>
> >
> >
> > I used a little different version of "cephfs" as "cephfs
> > /home/hemant/a set_layout --pool 3 -c 1 -u  4194304 -s  4194304"
> >  and "cephfs /home/hemant/b set_layout --pool 5 -c 1 -u  4194304 -s  4194304".
> >
> >
> > Now cmd didnt showed any error but When I put data to dir "a" & "b"
> > ideally it should go to different pool but its not working as of now.
> > Whatever I am doing is it possible (to use 2 dir pointing to 2
> > different pools for data placement) ?
> >
> >
> >
> > -
> > Hemant Surale.
> >
> > On Tue, Nov 27, 2012 at 10:21 PM, Sage Weil <sage@inktank.com> wrote:
> >> On Tue, 27 Nov 2012, hemant surale wrote:
> >>> I did "mkdir a " "chmod 777 a" . So dir "a" is /home/hemant/a" .
> >>> then I used "mount.ceph 10.72.148.245:/ /ho
> >>>
> >>> root@hemantsec-virtual-machine:/home/hemant# cephfs /home/hemant/a
> >>> set_layout --pool 3
> >>> Error setting layout: Invalid argument
> >>
> >> does 'ceph mds dump' list pool 3 in teh data_pools line?
> >>
> >> sage
> >>
> >>>
> >>> On Mon, Nov 26, 2012 at 9:56 PM, Sage Weil <sage@inktank.com> wrote:
> >>> > On Mon, 26 Nov 2012, hemant surale wrote:
> >>> >> While I was using "cephfs" following error is observed -
> >>> >> ------------------------------------------------------------------------------------------------
> >>> >> root@hemantsec-virtual-machine:~# cephfs /mnt/ceph/a --pool 3
> >>> >> invalid command
> >>> >
> >>> > Try
> >>> >
> >>> >  cephfs /mnt/ceph/a set_layout --pool 3
> >>> >
> >>> > (set_layout is the command)
> >>> >
> >>> > sage
> >>> >
> >>> >> usage: cephfs path command [options]*
> >>> >> Commands:
> >>> >>    show_layout    -- view the layout information on a file or dir
> >>> >>    set_layout     -- set the layout on an empty file,
> >>> >>                      or the default layout on a directory
> >>> >>    show_location  -- view the location information on a file
> >>> >> Options:
> >>> >>    Useful for setting layouts:
> >>> >>    --stripe_unit, -u:  set the size of each stripe
> >>> >>    --stripe_count, -c: set the number of objects to stripe across
> >>> >>    --object_size, -s:  set the size of the objects to stripe across
> >>> >>    --pool, -p:         set the pool to use
> >>> >>
> >>> >>    Useful for getting location data:
> >>> >>    --offset, -l:       the offset to retrieve location data for
> >>> >>
> >>> >> ------------------------------------------------------------------------------------------------
> >>> >> It may be silly question but unable to figure it out.
> >>> >>
> >>> >> :(
> >>> >>
> >>> >>
> >>> >>
> >>> >>
> >>> >> On Wed, Nov 21, 2012 at 8:59 PM, Sage Weil <sage@inktank.com> wrote:
> >>> >> > On Wed, 21 Nov 2012, hemant surale wrote:
> >>> >> >> > Oh I see.  Generally speaking, the only way to guarantee separation is to
> >>> >> >> > put them in different pools and distribute the pools across different sets
> >>> >> >> > of OSDs.
> >>> >> >>
> >>> >> >> yeah that was correct approach but i found problem doing so from
> >>> >> >> abstract level i.e. when I put file inside mounted dir
> >>> >> >> "/home/hemant/cephfs " ( mounted using "mount.ceph" cmd ) . At that
> >>> >> >> time anyways ceph is going to use default pool data to store files (
> >>> >> >> here files were striped into different objects and then sent to
> >>> >> >> appropriate osd ) .
> >>> >> >>    So how to tell ceph to use different pools in this case ?
> >>> >> >>
> >>> >> >> Goal : separate read and write operations , where read will be done
> >>> >> >> from one group of OSD and write is done to other group of OSD.
> >>> >> >
> >>> >> > First create the other pool,
> >>> >> >
> >>> >> >  ceph osd pool create <name>
> >>> >> >
> >>> >> > and then adjust the CRUSH rule to distributed to a different set of OSDs
> >>> >> > for that pool.
> >>> >> >
> >>> >> > To allow cephfs use it,
> >>> >> >
> >>> >> >  ceph mds add_data_pool <poolid>
> >>> >> >
> >>> >> > and then:
> >>> >> >
> >>> >> >  cephfs /mnt/ceph/foo --pool <poolid>
> >>> >> >
> >>> >> > will set the policy on the directory such that new files beneath that
> >>> >> > point will be stored in a different pool.
> >>> >> >
> >>> >> > Hope that helps!
> >>> >> > sage
> >>> >> >
> >>> >> >
> >>> >> >>
> >>> >> >>
> >>> >> >>
> >>> >> >>
> >>> >> >> -
> >>> >> >> Hemant Surale.
> >>> >> >>
> >>> >> >>
> >>> >> >> On Wed, Nov 21, 2012 at 12:33 PM, Sage Weil <sage@inktank.com> wrote:
> >>> >> >> > On Wed, 21 Nov 2012, hemant surale wrote:
> >>> >> >> >> Its a little confusing question I believe .
> >>> >> >> >>
> >>> >> >> >> Actually there are two files X & Y.  When I am reading X from its
> >>> >> >> >> primary .I want to make sure simultaneous writing of Y should go to
> >>> >> >> >> any other OSD except primary OSD for X (from where my current read is
> >>> >> >> >> getting served ) .
> >>> >> >> >
> >>> >> >> > Oh I see.  Generally speaking, the only way to guarantee separation is to
> >>> >> >> > put them in different pools and distribute the pools across different sets
> >>> >> >> > of OSDs.  Otherwise, it's all (pseudo)random and you never know.  Usually,
> >>> >> >> > they will be different, particularly as the cluster size increases, but
> >>> >> >> > sometimes they will be the same.
> >>> >> >> >
> >>> >> >> > sage
> >>> >> >> >
> >>> >> >> >
> >>> >> >> >>
> >>> >> >> >>
> >>> >> >> >> -
> >>> >> >> >> Hemant Sural.e
> >>> >> >> >>
> >>> >> >> >> On Wed, Nov 21, 2012 at 11:50 AM, Sage Weil <sage@inktank.com> wrote:
> >>> >> >> >> > On Wed, 21 Nov 2012, hemant surale wrote:
> >>> >> >> >> >> >>    and one more thing how can it be possible to read from one osd and
> >>> >> >> >> >> >> then simultaneous write to direct on other osd with less/no traffic?
> >>> >> >> >> >> >
> >>> >> >> >> >> > I'm not sure I understand the question...
> >>> >> >> >> >>
> >>> >> >> >> >> Scenario :
> >>> >> >> >> >>        I have written file X.txt on some osd which is primary for filr
> >>> >> >> >> >> X.txt ( direct write operation using rados cmd) .
> >>> >> >> >> >>        Now while read on file X.txt is in progress, Can I make sure
> >>> >> >> >> >> the simultaneous write request must be directed to other osd using
> >>> >> >> >> >> crushmaps/other way?
> >>> >> >> >> >
> >>> >> >> >> > Nope.  The object location is based on the name.  Reads and writes go to
> >>> >> >> >> > the same location so that a single OSD can serialize request.  That means,
> >>> >> >> >> > for example, that a read that follows a write returns the just-written
> >>> >> >> >> > data.
> >>> >> >> >> >
> >>> >> >> >> > sage
> >>> >> >> >> >
> >>> >> >> >> >
> >>> >> >> >> >> Goal of task :
> >>> >> >> >> >>        Trying to avoid read - write clashes as much as possible to
> >>> >> >> >> >> achieve faster operations (I/O) . Although CRUSH selects osd for data
> >>> >> >> >> >> placement based on pseudo random function.  is it possible ?
> >>> >> >> >> >>
> >>> >> >> >> >>
> >>> >> >> >> >>
> >>> >> >> >> >> -
> >>> >> >> >> >> Hemant Surale.
> >>> >> >> >> >>
> >>> >> >> >> >>
> >>> >> >> >> >>
> >>> >> >> >> >> On Tue, Nov 20, 2012 at 10:15 PM, Sage Weil <sage@inktank.com> wrote:
> >>> >> >> >> >> > On Tue, 20 Nov 2012, hemant surale wrote:
> >>> >> >> >> >> >> Hi Community,
> >>> >> >> >> >> >>    I have question about port number used by ceph-osd daemon . I
> >>> >> >> >> >> >> observed traffic (inter -osd communication while data ingest happened)
> >>> >> >> >> >> >> on port 6802 and then after some time when I ingested second file
> >>> >> >> >> >> >> after some delay port no 6804 was used . Is there any specific reason
> >>> >> >> >> >> >> to change port no here?
> >>> >> >> >> >> >
> >>> >> >> >> >> > The ports are dynamic.  Daemons bind to a random (6800-6900) port on
> >>> >> >> >> >> > startup and communicate on that.  They discover each other via the
> >>> >> >> >> >> > addresses published in the osdmap when the daemon starts.
> >>> >> >> >> >> >
> >>> >> >> >> >> >>    and one more thing how can it be possible to read from one osd and
> >>> >> >> >> >> >> then simultaneous write to direct on other osd with less/no traffic?
> >>> >> >> >> >> >
> >>> >> >> >> >> > I'm not sure I understand the question...
> >>> >> >> >> >> >
> >>> >> >> >> >> > sage
> >>> >> >> >> >> --
> >>> >> >> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> >> >> >> >> the body of a message to majordomo@vger.kernel.org
> >>> >> >> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> >> >> >> >>
> >>> >> >> >> >>
> >>> >> >> >>
> >>> >> >> >>
> >>> >> >>
> >>> >> >>
> >>> >>
> >>> >>
> >>>
> >>>
> 
> 
