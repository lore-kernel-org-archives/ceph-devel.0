From: Sage Weil <sage@newdream.net>
Subject: Re: OSD metadata reporting filestore when using bluestore
Date: Mon, 23 Jan 2017 18:20:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701231820030.3660@piezo.novalocal>
References: <1476304724.7893.1485195109298@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39325 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWSUx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 13:20:53 -0500
In-Reply-To: <1476304724.7893.1485195109298@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 23 Jan 2017, Wido den Hollander wrote:
> Hi,
> 
> Testing with Kraken 11.2.0 with BlueStore I noticed something regarding the OSD metadata.
> 
> $ ceph osd metadata 0
> 
> {
>     "id": 0,
>     "arch": "x86_64",
>     "back_addr": "[2001:db8::100]:6801\/3634",
>     "ceph_version": "ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)",
>     "cpu": "Intel(R) Core(TM) i5-3427U CPU @ 1.80GHz",
>     "distro": "ubuntu",
>     "distro_description": "Ubuntu 16.04.1 LTS",
>     "distro_version": "16.04",
>     "front_addr": "[2001:db8::100]:6800\/3634",
>     "hb_back_addr": "[2001:db8::100]:6802\/3634",
>     "hb_front_addr": "[2001:db8::100]:6803\/3634",
>     "hostname": "alpha",
>     "kernel_description": "#50-Ubuntu SMP Wed Jul 13 00:07:12 UTC 2016",
>     "kernel_version": "4.4.0-31-generic",
>     "mem_swap_kb": "522236",
>     "mem_total_kb": "500192",
>     "os": "Linux",
>     "osd_data": "\/var\/lib\/ceph\/osd\/ceph-0",
>     "osd_journal": "\/var\/lib\/ceph\/osd\/ceph-0\/journal",
>     "osd_objectstore": "filestore"
> }
> 
> The OSD in this case is however using Bluestore:
> 
> root@alpha:~# df -h /var/lib/ceph/osd/ceph-0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdb1        97M  5.4M   92M   6% /var/lib/ceph/osd/ceph-0
> root@alpha:~# cat /var/lib/ceph/osd/ceph-0/type
> bluestore
> root@alpha:~#
> 
> Looking at the code in src/osd/OSD.cc in void OSD::_collect_metadata(map<string,string> *pm):
> 
>   // backend
>   (*pm)["osd_objectstore"] = cct->_conf->osd_objectstore;
> 
> It seems that osd_objectstore is set to what is defined in the configuration, but in config_opts.h this defaults to filestore:
> 
> OPTION(osd_objectstore, OPT_STR, "filestore")  // ObjectStore backend type
> 
> It however seems that this configuration option doesn't do anything.
> 
> Am I correct or am I missing something here?

Yep, it's a bug!  The config option only controls mkfs behavior.  This 
should look at the instantiated store, not the config.  Open a ticket 
please?

sage
