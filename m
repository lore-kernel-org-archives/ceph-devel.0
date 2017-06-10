From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Sun, 11 Jun 2017 00:45:13 +0200
Message-ID: <948823304.20170611004513@tlen.pl>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>           
        <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>       
  <1464688590.20170523185052@tlen.pl>       
  <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>   
  <1075363645.20170523234331@tlen.pl>     
  <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal>     
  <135176900.20170524151952@tlen.pl>     
  <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>    
  <1203308391.20170524155848@tlen.pl>    
  <alpine.DEB.2.11.1705241401260.3646@piezo.novalocal>  
  <379087365.20170524161815@tlen.pl>   
  <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal>  
  <2910218531.20170524233842@tlen.pl>  
  <alpine.DEB.2.11.1705242149300.3646@piezo.novalocal>
  <804507840.20170525000904@tlen.pl>
  <alpine.DEB.2.11.1705242227320.3646@piezo.novalocal>
  <154794248.20170525004623@tlen.pl>
  <alpine.DEB.2.11.1705301315220.3646@piezo.novalocal>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.145]:56182 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbdFJWp1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 10 Jun 2017 18:45:27 -0400
In-Reply-To: <alpine.DEB.2.11.1705301315220.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

> Okay, sorry I took a while to get back to you.

Sorry too - most of time I was focused on this problem.

>  It looks like I gave
> you bad advice here!  The 'nosnap' files means filestore was 
> operating in non-snapshotting mode, and the --osd-use-stale-snap 
> warning that it would lose data was real... it rolled back to an empty
> state and threw out the data on the device.  :( :(  I'm *very* sorry about
> this!  I haven't looked at or worked with the btrfs mode is ages (we 
> don't recommend it and almost nobody uses it) but I should have been 
> paying close attention.

Thank  You  for  Your  time  and effort, it was important to have such
help.  There  were  many  errors  in  setup of this cluster. We didn't
relize  that  there could be so much strange things, which were f...ed
up...

> What is the state of the cluster now?

Cluster is dead. After few more days of fight with cluster we decieded
to  shut  it  down  and  we  fixed scripts for recovering volumes from
turned         off        ceph        cluster        (this        one:
https://github.com/cmgitdream/ceph-rbd-recover-tool)   and   make   it
running for jewel version (10.2.7). I setup brand new cluster on other
hardware and now images are importing to new cluster. With some direct
edition  of  mysql  in  openstack  systems  we  didn't  had  to change
everything  for  our clients from horizon point of view. Once the dust
settles, we will add changes to github for this tool.

After  end  of migration we will try to run this dead cluster and make
some more agressive action to make it work anyway.



-- 
Regards,,
 Lukasz

