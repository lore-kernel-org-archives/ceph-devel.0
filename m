From: Sage Weil <sage@inktank.com>
Subject: RE: bug in /etc/init.d/ceph debian
Date: Fri, 9 Aug 2013 17:35:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308091733080.312@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B62E7617E@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62E82A96@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308070822180.3006@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B62E84BA8@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308080843400.18359@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B62E86B22@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308081809410.11353@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B62E8B318@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308090816520.12756@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B62E8C851@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39791 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968048Ab3HJAfS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 20:35:18 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E8C851@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 9 Aug 2013, James Harper wrote:
> > > But I think this still won't have the desired outcome if you have 2 OSD's.
> > > The possible situations if the resource is supposed to be running are:
> > > . Both running => all good, pacemaker will do nothing
> > > . Both stopped => all good, pacemaker will start the services
> > > . One stopped one running => not good, pacemaker won't make any effort
> > > to start services
> > 
> > If one daemon si stopped and one is running, returning 'not running' seems
> > ok to me, since 'start' at that point will do the right thing.
> 
> Maybe. If the stopped daemon is stopped because it fails to start then pacemaker might get unhappy when subsequent starts also fail, and might even get STONITHy.

This is sounding more like we're trying to fit a square peg in a round 
hole.  Generally speaking there is *never* any need for anything that 
resembles STONITH with Ceph; all of that is handled internally by Ceph 
itself.

I think the only real reason why you would want to use pacemaker here is 
if you just like it better than the normal startup scripts, or perhaps 
because you are using it to control where the standby mdss run.  So maybe 
we are barking up the wrong tree...

sage


> 
> > > . One in error, one running => not good. I'm not sure exactly what will
> > > happen but it won't be what you expect.
> > 
> > I think it's fine for this to be an error condition.
> 
> Again. If pacemaker see's the error it might start doing things you don't want.
> 
> Technically, for actual clustered resources, returning "not running" when something is running is about the worst thing you can do because pacemaker might then start up the resource on another node (eg start a VM on two nodes at once, corrupting the fs). The way you'd set this up for ceph though is just a cloned resource on each node so it wouldn't matter anyway.
> 
> > >
> > > The only solution I can see is to manage the services individually, in
> > > which case the init.d script with your patch + setting to 0 if running
> > > does the right thing anyway.
> > 
> > Yeah, managing individually is probably the most robust, but if it works
> > well enough in the generic configuration with no customization that is
> > good.
> 
> Actually it subsequently occurred to me that if I set them up individually then my dependencies will break (eg start ceph before mounting ceph-fs) because there are now different ceph instances per node.
> 
> > 
> > Anyway, I'm fine with whatever variation of your original or my patch you
> > think addresses this.  A comment block in the init-ceph script documenting
> > what the return codes mean (similar to the above) would be nice so that
> > it is clear to the next person who comes along.
> > 
> 
> I might post on the pacemaker list and see what the thoughts are there.
> 
> Maybe it would be better for me to just re-order the init.d scripts so ceph starts in init.d and leave it at that...
> 
> James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
