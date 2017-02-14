From: "wido@42on.com" <wido@42on.com>
Subject: Re: OSD has the store locked???
Date: Tue, 14 Feb 2017 16:23:05 +0100
Message-ID: <598746059.1724.1487085785680.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
References: <557f1d59-33c5-3da3-926e-f87160da272b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:39125 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdBNPXJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 10:23:09 -0500
In-Reply-To: <557f1d59-33c5-3da3-926e-f87160da272b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



> Op 14 feb. 2017 om 14:57 heeft Willem Jan Withagen <wjw@digiware.nl> het volgende geschreven:
> 
> Hi,
> 
> Running ceph_objectstore_tool.py just about all command get the
> complaint that "OSD has the store locked".
> 

Is the OSD still running? If so, stop it first.

Wido

> Like:
> Test --op list variants
> OSD has the store locked
> ERROR:Bad exit status 1 from
> /home/jenkins/workspace/ceph-master/build/bin/ceph-objectstore-tool
> --data-path /home/jenkins/workspace/ceph-master/build/cot_dir/dev/osd0
> --op list --format json
> 
> Why would I get "the store locked"??
> 
> Thanx,
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
