From: Sage Weil <sage@newdream.net>
Subject: Re: Luminous RC feedback - device classes and osd df weirdness
Date: Wed, 19 Jul 2017 14:53:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707191451340.27271@piezo.novalocal>
References: <71ce32a8-6232-0f5b-35a5-d86f30a045db@catalyst.net.nz> <f0536e0e-b9a1-6ef5-c96e-81e873bda624@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50068 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755108AbdGSOxn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jul 2017 10:53:43 -0400
In-Reply-To: <f0536e0e-b9a1-6ef5-c96e-81e873bda624@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 19 Jul 2017, Mark Kirkwood wrote:
> On 29/06/17 17:04, Mark Kirkwood wrote:
> 
> > 
> > 
> > That all went very smoothly, with only a couple of things that seemed weird.
> > Firstly the crush/osd tree output is a bit strange (but I could get to the
> > point where it make sense):
> > 
> > $ sudo ceph osd tree
> > ID  WEIGHT  TYPE NAME          UP/DOWN REWEIGHT PRIMARY-AFFINITY
> > -15 0.23196 root default~ssd
> > -11 0.05699     host ceph1~ssd
> >   4 0.05699         osd.4           up  1.00000 1.00000
> > -12 0.05899     host ceph2~ssd
> >   5 0.05899         osd.5           up  1.00000 1.00000
> > -13 0.05699     host ceph3~ssd
> >   6 0.05699         osd.6           up  1.00000 1.00000
> > -14 0.05899     host ceph4~ssd
> >   7 0.05899         osd.7           up  1.00000 1.00000
> > -10 0.07996 root default~hdd
> >  -6 0.01999     host ceph1~hdd
> >   0 0.01999         osd.0           up  1.00000 1.00000
> >  -7 0.01999     host ceph2~hdd
> >   1 0.01999         osd.1           up  1.00000 1.00000
> >  -8 0.01999     host ceph3~hdd
> >   2 0.01999         osd.2           up  1.00000 1.00000
> >  -9 0.01999     host ceph4~hdd
> >   3 0.01999         osd.3           up  1.00000 1.00000
> >  -1 0.31198 root default
> >  -2 0.07700     host ceph1
> >   0 0.01999         osd.0           up  1.00000 1.00000
> >   4 0.05699         osd.4           up  1.00000 1.00000
> >  -3 0.07899     host ceph2
> >   1 0.01999         osd.1           up  1.00000 1.00000
> >   5 0.05899         osd.5           up  1.00000 1.00000
> >  -4 0.07700     host ceph3
> >   2 0.01999         osd.2           up  1.00000 1.00000
> >   6 0.05699         osd.6           up  1.00000 1.00000
> >  -5 0.07899     host ceph4
> >   3 0.01999         osd.3           up  1.00000 1.00000
> >   7 0.05899         osd.7           up  1.00000 1.00000
> > 
> > 
> > But the osd df output is baffling, I've got two identical lines for each osd
> > (hard to see immediately - sorting by osd id would make it easier). This is
> > not ideal, particularly as for the bluestore guys there is no other way to
> > work out utilization. Any ideas - have I done something obviously wrong here
> > that is triggering the 2 lines?
> > 
> > $ sudo ceph osd df
> > ID WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE VAR  PGS
> >  4 0.05699  1.00000 60314M  1093M 59221M 1.81 1.27   0
> >  5 0.05899  1.00000 61586M  1234M 60351M 2.00 1.40   0
> >  6 0.05699  1.00000 60314M  1248M 59066M 2.07 1.45   0
> >  7 0.05899  1.00000 61586M  1209M 60376M 1.96 1.37   0
> >  0 0.01999  1.00000 25586M 43812k 25543M 0.17 0.12  45
> >  1 0.01999  1.00000 25586M 42636k 25544M 0.16 0.11  37
> >  2 0.01999  1.00000 25586M 44336k 25543M 0.17 0.12  53
> >  3 0.01999  1.00000 25586M 42716k 25544M 0.16 0.11  57
> >  0 0.01999  1.00000 25586M 43812k 25543M 0.17 0.12  45
> >  4 0.05699  1.00000 60314M  1093M 59221M 1.81 1.27   0
> >  1 0.01999  1.00000 25586M 42636k 25544M 0.16 0.11  37
> >  5 0.05899  1.00000 61586M  1234M 60351M 2.00 1.40   0
> >  2 0.01999  1.00000 25586M 44336k 25543M 0.17 0.12  53
> >  6 0.05699  1.00000 60314M  1248M 59066M 2.07 1.45   0
> >  3 0.01999  1.00000 25586M 42716k 25544M 0.16 0.11  57
> >  7 0.05899  1.00000 61586M  1209M 60376M 1.96 1.37   0
> >               TOTAL   338G  4955M   333G 1.43
> > MIN/MAX VAR: 0.11/1.45  STDDEV: 0.97
> 
> Revisiting these points after reverting to Jewel again and freshly upgrading
> to 12.1.1:
> 
> $ sudo ceph osd tree
> ID CLASS WEIGHT  TYPE NAME      UP/DOWN REWEIGHT PRI-AFF
> -1       0.32996 root default
> -2       0.08199     host ceph1
>  0   hdd 0.02399         osd.0       up  1.00000 1.00000
>  4   ssd 0.05699         osd.4       up  1.00000 1.00000
> -3       0.08299     host ceph2
>  1   hdd 0.02399         osd.1       up  1.00000 1.00000
>  5   ssd 0.05899         osd.5       up  1.00000 1.00000
> -4       0.08199     host ceph3
>  2   hdd 0.02399         osd.2       up  1.00000 1.00000
>  6   ssd 0.05699         osd.6       up  1.00000 1.00000
> -5       0.08299     host ceph4
>  3   hdd 0.02399         osd.3       up  1.00000 1.00000
>  7   ssd 0.05899         osd.7       up  1.00000 1.00000
> 
> This looks much more friendly!
> 
> $ sudo ceph osd df
> ID CLASS WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE  VAR PGS
>  0   hdd 0.02399  1.00000 25586M 89848k 25498M  0.34 0.03 109
>  4   ssd 0.05699  1.00000 60314M 10096M 50218M 16.74 1.34 60
>  1   hdd 0.02399  1.00000 25586M 93532k 25495M  0.36 0.03 103
>  5   ssd 0.05899  1.00000 61586M  9987M 51598M 16.22 1.30 59
>  2   hdd 0.02399  1.00000 25586M 88120k 25500M  0.34 0.03 111
>  6   ssd 0.05699  1.00000 60314M 12403M 47911M 20.56 1.64 75
>  3   hdd 0.02399  1.00000 25586M 94688k 25494M  0.36 0.03 125
>  7   ssd 0.05899  1.00000 61586M 10435M 51151M 16.94 1.36 62
>                     TOTAL   338G 43280M   295G 12.50
> MIN/MAX VAR: 0.03/1.64  STDDEV: 9.40
> 
> ...and this is vastly better too. Bit of a toss up whether ordering by host
> (which is what it seems to be happening here) or ordering by osd id is better,
> but clearly there are bound to be differing POV on this - I'm happy with the
> current choice.

Great!  I think the result is actaully ordered by the tree code but just 
doesn't format that way (and show the tree nodes).  It is a little weird, 
I agree.
 
> One (I think) new thing compared to the 12.1.0 is that restarting the services
> blitzes the modified crushmap, and we get back to:
> 
> $ sudo ceph osd tree
> ID CLASS WEIGHT  TYPE NAME      UP/DOWN REWEIGHT PRI-AFF
> -1       0.32996 root default
> -2       0.08199     host ceph1
>  0   hdd 0.02399         osd.0       up  1.00000 1.00000
>  4   hdd 0.05699         osd.4       up  1.00000 1.00000
> -3       0.08299     host ceph2
>  1   hdd 0.02399         osd.1       up  1.00000 1.00000
>  5   hdd 0.05899         osd.5       up  1.00000 1.00000
> -4       0.08199     host ceph3
>  2   hdd 0.02399         osd.2       up  1.00000 1.00000
>  6   hdd 0.05699         osd.6       up  1.00000 1.00000
> -5       0.08299     host ceph4
>  3   hdd 0.02399         osd.3       up  1.00000 1.00000
>  7   hdd 0.05899         osd.7       up  1.00000 1.00000
> 
> ...and all the PG are remapped again. Now I might have just missed this
> happening with 12.1.0 - but I'm (moderately) confident that I did restart
> stuff and not see this happening. For now I've added:
> 
> osd crush update on start = false
> 
> to my ceph.conf to avoid being caught by this.

Can you share teh output of 'ceph osd metadata 0' vs 'cpeh osd metadata 
4'?  I'm not sure why it's getting the class wrong.  I haven't seen this 
on my cluster (it's bluestore; maybe that's the difference).

Thanks!
sage
