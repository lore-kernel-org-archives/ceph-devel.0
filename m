From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Mon, 11 Feb 2013 19:54:24 +0100
Message-ID: <20130211185424.GA27669@kdecherf.com>
References: <20130204180154.GO3286@kdecherf.com>
 <20130211130518.GN6997@kdecherf.com>
 <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:53499 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758949Ab3BKSy3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 13:54:29 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so4909499wey.4
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 10:54:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Mon, Feb 11, 2013 at 11:00:15AM -0600, Sam Lang wrote:
> Hi Kevin, sorry for the delayed response.
> This looks like the mds cache is thrashing quite a bit, and with
> multiple MDSs the tree partitioning is causing those estale messages.
> In your case, you should probably run with just a single active mds (I
> assume all three MDSs are active, but ceph -s will tell you for sure),
> and the others as standby.  I don't think you'll be able to do that
> without starting over though.

Hi Sam,

I know that MDS clustering is a bit buggy so I have only one active MDS
on this cluster.

Here is the output of ceph -s:

   ~ # ceph -s
      health HEALTH_OK
      monmap e1: 3 mons at {a=x:6789/0,b=y:6789/0,c=z:6789/0}, election epoch 48, quorum 0,1,2 a,b,c
      osdmap e79: 27 osds: 27 up, 27 in
       pgmap v895343: 5376 pgs: 5376 active+clean; 18987 MB data, 103 GB used, 21918 GB / 23201 GB avail
      mdsmap e73: 1/1/1 up {0=b=up:active}, 2 up:standby


> Also, you might want to increase the size of the mds cache if you have
> enough memory on that machine.  mds cache size defaults to 100k, you
> might increase it to 300k and see if you get the same problems.

I have 24GB of memory for each MDS, I will try to increase this value.
Thanks for advice.

> Do you have debug logging enabled when you see this crash?  Can you
> compress that mds log and post it somewhere or email it to me?

Yes, I have 34GB of raw logs (for this issue) but I have no debug log
of the beginning of the storm itself. I will upload a compressed
archive.


Furthermore, I observe another strange thing more or less related to the
storms.

During a rsync command to write ~20G of data on Ceph and during (and
after) the storm, one OSD sends a lot of data to the active MDS
(400Mbps peak each 6 seconds). After a quick check, I found that when I
stop osd.23, osd.14 stops its peaks.

I will forward a copy of the debug enabled log of osd14.

The only significant difference between osd.23 and others is the list of
hb_in where osd.14 is missing (but I think it's unrelated).

   ~ # ceph pg dump
   osdstat  kbused   kbavail  kb hb in hb out
   0  4016228  851255948   901042464   [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   1  4108748  851163428   901042464   [0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26]  []
   2  4276584  850995592   901042464   [0,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   3  3997368  851274808   901042464   [0,1,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26] []
   4  4358212  850913964   901042464   [0,1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   5  4039112  851233064   901042464   [0,1,2,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   6  3971568  851300608   901042464   [0,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   7  3942556  851329620   901042464   [0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   8  4275584  850996592   901042464   [0,1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   9  4279308  850992868   901042464   [0,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]  []
   10 3728136  851544040   901042464   [0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]   []
   11 3934096  851338080   901042464   [0,1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]   []
   12 3991600  851280576   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26]   []
   13 4211228  851060948   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,25,26]   []
   14 4169476  851102700   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26]   []
   15 4385584  850886592   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26]   []
   16 3761176  851511000   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26]   []
   17 3646096  851626080   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26]   []
   18 4119448  851152728   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,20,21,22,23,24,25,26]   []
   19 4592992  850679184   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22,23,24,25,26]   []
   20 3740840  851531336   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26]   []
   21 4363552  850908624   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26]   []
   22 3831420  851440756   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,26]   []
   23 3681648  851590528   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,24,25,26]   []
   24 3946192  851325984   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26]   []
   25 3954360  851317816   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26]   []
   26 3775532  851496644   901042464   [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]   []
    sum  109098644   22983250108 24328146528

Cheers,
-- 
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
