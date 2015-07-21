From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: upstream/firefly exporting the same snap 2 times results in
 different exports
Date: Tue, 21 Jul 2015 16:48:13 -0400 (EDT)
Message-ID: <1072106728.1587536.1437511693819.JavaMail.zimbra@redhat.com>
References: <55AE3B3A.2040902@profihost.ag> <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com> <55AE798F.1010206@profihost.ag> <1828157940.1473499.1437499191528.JavaMail.zimbra@redhat.com> <55AE9BD9.6010801@profihost.ag> <55AEA17A.8040901@redhat.com> <55AEA1F1.8030400@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:35507 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbbGUUsS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 16:48:18 -0400
In-Reply-To: <55AEA1F1.8030400@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Josh Durgin <jdurgin@redhat.com>, ceph-devel@vger.kernel.org

> > That sounds very odd. Could you verify via 'rados listwatchers' on an
> > in-use rbd image's header object that there's still a watch established?
> 
> How can i do this exactly?
> 

You need to determine the RBD header object name.  For format 1 images (default for Firefly), the image header object is named "<image name>.rbd".  For format 2 images, you can determine the header object name via "rbd info <image spec> | grep 'block_name_prefix' | sed 's/.*rbd_data\.\(.*\)/rbd_header.\1/g'".

Once you have the RBD image header object name, you can run: "rados listwatchers -p <pool name> <RBD image header name>". 

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 
