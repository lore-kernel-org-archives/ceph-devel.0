From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: Request for ceph.conf environment extension / IB performance
Date: Mon, 6 May 2013 18:02:31 +0200
Message-ID: <20130506160231.GA10198@oder>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
 <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:23598 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab3EFQNS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 12:13:18 -0400
Content-Disposition: inline
In-Reply-To: <CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "Friedrich, Andreas" <andreas.friedrich@ts.fujitsu.com>, Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 06, 2013 at 02:36:39PM +0200, Gandalf Corvotempesta wrote:
> 2013/5/6 Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>:
> > To enable the LD_PRELOAD mechanism for the Ceph daemons only, a little
> > generic extension in the global section of /etc/ceph/ceph.conf would
> > be helpful, e.g.:
> >
> > [global]
> >         environment = LD_PRELOAD=/usr/lib64/libsdp.so.1
> >
> > The appending patch adds 5 lines in the Bobtail (0.56.6) init script.
> > The init script will then read the environment setting and - if present -
> > call the Ceph daemons with the preceding environment string.
> 
> Cool! We are planning the same infrastructure with IB as networking.
> Could you share more details about this?
>  - which performance are you having and on which hardware?

6x Storage-Server, each with 3x Intel-910 PCIe-SSD (OSD-xfs), Journal in 1GB RAM-Disk per OSD
plus 1x Client-server, each Server with 10GbE, Intel-QDR as well as MLX-FDR

The performance values are still scattering ...
(1 fio client job, 128 QD, 1TB of data, 60 seconds)
e.g. 
- read_4m_128, read_8m_128, randread_4m_128, randread_8m_128		approx. 2.2 GB/s on 56 GbIPoIB_CM and 56 GbSDP
- write_4m_128, write_8m_128, randwrite_4m_128, randwrite_8m_128	approx. 500 MB/s on 56 GbIPoIB_CM and 56 GbSDP,
									but     900 MS/s on 40 GbIPoIB_CM
>  - any issue with IB and SDP?
Well, you have to compile the complete OFED stack (ib_core, ... ib_sdp) from one vendor.
MLX is running, the Intel status is 'wip' ... the cluster is up, but jerking ... 
(OSDs are getting out/in ... timeouts) looks like a shortage on ressource ?!

>  - are you able to use the newer rsockets and not SDP? It also has a
> preloader library and is still developed (SDP is deprecated)
rsockets.so is up, but stuttering ... 

... and for the moment rsockets is UserLand only, in contrast to sdp.ko

Cheers,
-Dieter

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
