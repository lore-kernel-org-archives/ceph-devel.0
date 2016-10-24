From: Sage Weil <sage@newdream.net>
Subject: Re: Question about OSDSuperblock
Date: Mon, 24 Oct 2016 10:06:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610241000230.14316@piezo.us.to>
References: <463456f6.b4bb.157f5bb2656.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-176358657-1477303224=:14316"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37668 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbcJXKGs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 06:06:48 -0400
In-Reply-To: <463456f6.b4bb.157f5bb2656.Coremail.xxhdx1985126@163.com>
Content-ID: <alpine.DEB.2.11.1610241001000.14316@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-176358657-1477303224=:14316
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1610241001001.14316@piezo.us.to>

On Mon, 24 Oct 2016, xxhdx1985126 wrote:
> Hi, everyone.
> 
> 
> I'm trying to read the source code that boots an OSD instance, and I find something really overwhelms me.
> In the OSD::init() method, it read the OSDSuperblock by calling OSD::read_superblock(), and the it tried to get the "current" map : "osdmap = get_map(superblock.current_epoch)". Then OSD uses this osdmap to calculate the acting and up set of each pg. 
> I really don't understand this! Since the OSDSuperblock is read from the disk, the content of the superblock.current_epoch must be an old epoch which is recorded by the last OSD instance that run on the ceph osd's directory. Why use an old "current_epoch" to calculate the acting and up set of each pg?

Yes.  load_pgs() instantiates all of the PGs, populates the current (== 
current_epoch) up and acting vectors, and triggers a loaded event to help 
get everything in-memory initialized.

Then, during the 'booting' sequence, we request the latest map from the 
monitor, and respond to any changes in the OSDMap--everything that 
happened while the OSD was down, and eventually the OSDmap that indicates 
the OSD is now up.  At that point it can start doing useful work. Look for 
the AdvMap and ActMap state events.

This process of responding to changes to the OSDMap and synchronizing with 
other OSDs in collectively called "peering" and is one of the more 
difficult areas of the code to understand.  :/

sage

--8323329-176358657-1477303224=:14316--
