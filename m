From: Wido den Hollander <wido@42on.com>
Subject: Re: OSD metadata reporting filestore when using bluestore
Date: Mon, 23 Jan 2017 19:21:57 +0100 (CET)
Message-ID: <1439718724.7900.1485195718228@ox.pcextreme.nl>
References: <1476304724.7893.1485195109298@ox.pcextreme.nl>
 <alpine.DEB.2.11.1701231820030.3660@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:49358 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdAWSWD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 13:22:03 -0500
In-Reply-To: <alpine.DEB.2.11.1701231820030.3660@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 23 januari 2017 om 19:20 schreef Sage Weil <sage@newdream.net>:
> 
> 
> On Mon, 23 Jan 2017, Wido den Hollander wrote:
> > Hi,
> > 
> > Testing with Kraken 11.2.0 with BlueStore I noticed something regarding the OSD metadata.
> > 
> > $ ceph osd metadata 0
> > 
> > {
> >     "id": 0,
> >     "arch": "x86_64",
> >     "back_addr": "[2001:db8::100]:6801\/3634",
> >     "ceph_version": "ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)",
> >     "cpu": "Intel(R) Core(TM) i5-3427U CPU @ 1.80GHz",
> >     "distro": "ubuntu",
> >     "distro_description": "Ubuntu 16.04.1 LTS",
> >     "distro_version": "16.04",
> >     "front_addr": "[2001:db8::100]:6800\/3634",
> >     "hb_back_addr": "[2001:db8::100]:6802\/3634",
> >     "hb_front_addr": "[2001:db8::100]:6803\/3634",
> >     "hostname": "alpha",
> >     "kernel_description": "#50-Ubuntu SMP Wed Jul 13 00:07:12 UTC 2016",
> >     "kernel_version": "4.4.0-31-generic",
> >     "mem_swap_kb": "522236",
> >     "mem_total_kb": "500192",
> >     "os": "Linux",
> >     "osd_data": "\/var\/lib\/ceph\/osd\/ceph-0",
> >     "osd_journal": "\/var\/lib\/ceph\/osd\/ceph-0\/journal",
> >     "osd_objectstore": "filestore"
> > }
> > 
> > The OSD in this case is however using Bluestore:
> > 
> > root@alpha:~# df -h /var/lib/ceph/osd/ceph-0
> > Filesystem      Size  Used Avail Use% Mounted on
> > /dev/sdb1        97M  5.4M   92M   6% /var/lib/ceph/osd/ceph-0
> > root@alpha:~# cat /var/lib/ceph/osd/ceph-0/type
> > bluestore
> > root@alpha:~#
> > 
> > Looking at the code in src/osd/OSD.cc in void OSD::_collect_metadata(map<string,string> *pm):
> > 
> >   // backend
> >   (*pm)["osd_objectstore"] = cct->_conf->osd_objectstore;
> > 
> > It seems that osd_objectstore is set to what is defined in the configuration, but in config_opts.h this defaults to filestore:
> > 
> > OPTION(osd_objectstore, OPT_STR, "filestore")  // ObjectStore backend type
> > 
> > It however seems that this configuration option doesn't do anything.
> > 
> > Am I correct or am I missing something here?
> 
> Yep, it's a bug!  The config option only controls mkfs behavior.  This 
> should look at the instantiated store, not the config.  Open a ticket 
> please?
> 

I will! I'll also take a try with a PR to go along with it.

Wido

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
