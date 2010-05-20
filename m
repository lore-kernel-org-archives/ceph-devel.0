From: Michal Humpula <michal.humpula@hudrydum.cz>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 22:10:01 +0200
Message-ID: <201005202210.02097.michal.humpula@hudrydum.cz>
References: <909721.18944.qm@web114302.mail.gq1.yahoo.com> <1274378233.5412.63.camel@wido-laptop.pcextreme.nl> <Pine.LNX.4.64.1005201102570.4397@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1250"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hudrydum.cz ([88.208.90.178]:59010 "EHLO hudrydum.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab0ETUQ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 May 2010 16:16:57 -0400
In-Reply-To: <Pine.LNX.4.64.1005201102570.4397@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thursday 20 of May 2010 20:24:50 you wrote:
> On Thu, 20 May 2010, Wido den Hollander wrote:
> > Hi,
> >
> > On Thu, 2010-05-20 at 17:09 +0000, Sage Weil wrote:
> > > > > I'd prefer the situation where i'd stripe over all 4 disks, giving
> > > > > me and extra pro. In this situation i could configure my node to
> > > > > panic whenever a disk is starting to give errors, so my cluster can
> > > > > take over immediately.
> > > > >
> > > > > Am i right? Is this "the way to go"?
> > > >
> > > > I don't know the way to go. But I think that in the 1st case (1 OSD
> > > > per hard disk) when a hard disk fails, it gets replicated elsewhere.
> > > > During that time the other 3 OSDs on the same machine are still
> > > > working fine and serving requests. And then some time later, you've
> > > > got a brand new disk, you shutdown the machnie, that's 3 more OSDs
> > > > down. In the 2nd case, as soon as 1 disk starts failing, your OSD
> > > > (which is 4 disks) gets taken down, that's approximately equivalent
> > > > to 4 OSDs going down at the same time if we compare to your 1st case.
> > >
> > > The other 3 osds don't have to rereplicate if you swap the failed disk
> > > quickly, or otherwise inform the system that the failure is temporary. 
> > > By default there is a 5 minute timeout.  That can be adjusted, or we
> > > can add other administrative hooks to 'suspend' any declarations of
> > > permanent failure for this sort of case.
> >
> > Ok, so upping this timeout to something like 10 minutes would be
> > sufficient for swapping and OSD.
> >
> > This is done via the mon_osd_down_out_interval paramater i assume (found
> > in config.cc)
> 
> Yes.  And you can modify this value on a running system (without modifying
> the .conf and restarting the monitor) with
> 
> $ ceph mon injectargs \* '--mon_osd_down_out_interval 600'
> 
> on the latest unstable.
> 
> > About more then one OSD on one machine, is there a way how you can bind
> > an OSD to a specific IP? Can't seem to find any configuration for this.
> >
> > I assume you will need one IP per OSD on that machine?
> 
> Not currently via the .conf, only via the --bind 1.2.3.4:123 command line
> argument.  Adding a bug for this.

Is that one IP per cosd daemon really necessary?  I'm currently running four 
osd nodes, two disk/cosd per each with single IP per node. So far it seems 
working:)

> > And my journaling question, any views on that topic?
> 
> I don't thank that turning the write cache off will affect btrfs too much,
> but I haven't tested it.  It does need to be off if you use a separate
> partition.  The other alternative is to put the journal file in btrfs, but
> that is slower.
> 
> sage
> 
> > Thanks!
> >
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Michal Humpula
