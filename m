From: Sage Weil <sage@inktank.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal,
  normal behaviour ?
Date: Mon, 2 Jul 2012 14:02:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207021358591.24205@cobra.newdream.net>
References: <4FDF4641.4070405@inktank.com> <2709e9e7-eed5-49c4-b7d2-9b0c7b0b9c3c@mailpro>
 <CAPYLRzh5BCeHfSZ+gfcrShRiT2JErYbZiy5Xwj=103XYUr_ajQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33519 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092Ab2GBVCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 17:02:17 -0400
In-Reply-To: <CAPYLRzh5BCeHfSZ+gfcrShRiT2JErYbZiy5Xwj=103XYUr_ajQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On Mon, 2 Jul 2012, Gregory Farnum wrote:
> On Tue, Jun 19, 2012 at 12:09 AM, Alexandre DERUMIER
> <aderumier@odiso.com> wrote:
> > Hi, more infos, I have active filestore debug = 20, min interval 29 and max interval 30.
> >
> > I see sync_entry each 30s, so it seem work as expected.
> >
> > cat ceph-osd.0.log |grep sync_entry
> > 2012-06-19 07:56:00.084622 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 26.550294
> > 2012-06-19 07:56:00.084641 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for another 2.449706 to reach min interval 29.000000
> > 2012-06-19 07:56:02.534432 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committing 18717 sync_epoch 5
> > 2012-06-19 07:56:02.534481 7fd09233b700 15 filestore(/srv/osd.0) sync_entry doing a full sync (syncfs(2) if possible)
> > 2012-06-19 07:56:02.963302 7fd09233b700 10 filestore(/srv/osd.0) sync_entry commit took 0.428878, interval was 29.428974
> > 2012-06-19 07:56:02.963332 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committed to op_seq 18717
> > 2012-06-19 07:56:02.963341 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000
> > 2012-06-19 07:56:12.066002 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 9.102662
> > 2012-06-19 07:56:12.066024 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for another 19.897338 to reach min interval 29.000000
> > 2012-06-19 07:56:31.963460 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committing 18935 sync_epoch 6
> > 2012-06-19 07:56:31.963510 7fd09233b700 15 filestore(/srv/osd.0) sync_entry doing a full sync (syncfs(2) if possible)
> > 2012-06-19 07:56:32.279737 7fd09233b700 10 filestore(/srv/osd.0) sync_entry commit took 0.316285, interval was 29.316396
> > 2012-06-19 07:56:32.279778 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committed to op_seq 18935
> > 2012-06-19 07:56:32.279786 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000
> > 2012-06-19 07:56:44.837731 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 12.557945
> > 2012-06-19 07:56:44.837757 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for another 16.442055 to reach min interval 29.000000
> > 2012-06-19 07:57:01.279894 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committing 19125 sync_epoch 7
> > 2012-06-19 07:57:01.279939 7fd09233b700 15 filestore(/srv/osd.0) sync_entry doing a full sync (syncfs(2) if possible)
> > 2012-06-19 07:57:01.558240 7fd09233b700 10 filestore(/srv/osd.0) sync_entry commit took 0.278354, interval was 29.278455
> > 2012-06-19 07:57:01.558282 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committed to op_seq 19125
> > 2012-06-19 07:57:01.558291 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000
> > 2012-06-19 07:57:31.558394 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 30.000104
> > 2012-06-19 07:57:31.558414 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000
> >
> >
> > But during all the time of the bench, I have flusher_entry logs.
> > What is exactly flush_entry vs sync_entry?
> 
> flush_entry is doing sync_file_range, which sends the data to the disk
> but doesn't flush disk caches, or do a whole host of other things that
> are needed to maintain integrity. The idea is that we don't want the
> filesystem to store up thirty seconds worth of writes and then sync
> them out on command, but rather to continuously do writes to disk.
> sync_file_range is the best tool we have for accomplishing that.
> 
> However, you could try turning it off and seeing if your performance
> improves. :) Set filestore_sync_flush and filestore_flusher to false
> in your config file.

One alternative is to let the kernel do this.  If you adjust the VM 
tunables with something like

	echo 10000000 > /proc/sys/vm/dirty_background_bytes

and set

	filestore flusher = false

that will rely on the kernel to keep the amount of dirty data small.  This 
affects the entire host, though, so keep in mind that it will affect other 
processes and all mounted file systems.  Conceptually, this is what we are 
trying to accomplish with the flushing stuff, but it's hard to do from a 
user process.  Maybe the new cgroups stuff will make some of this 
easier... I haven't been following it very closely.

sage
