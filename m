From: "Adam C. Emerson" <aemerson@cohortfs.com>
Subject: Re: loadable objectstore
Date: Mon, 22 Jun 2015 12:08:58 -0400
Message-ID: <20150622160858.GA13258@linuxbox.com>
References: <1615100301.29.1434984131967.JavaMail.root@thunderbeast.private.linuxbox.com>
 <46879752.37.1434985621131.JavaMail.root@thunderbeast.private.linuxbox.com>
 <C226B0AB34511445928D9882AA519F601C434076@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1456 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbbFVQPz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Jun 2015 12:15:55 -0400
Content-Disposition: inline
In-Reply-To: <C226B0AB34511445928D9882AA519F601C434076@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: "Matt W. Benjamin" <matt@cohortfs.com>, Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

On 22/06/2015, Varada Kari wrote:
> Hi Matt,
> 
> Majority of the changes are segregating the files to corresponding shared object and creating a factory object. And the naming is mostly taken from Erasure-coding plugins. Want a good naming convention :-), hence a preliminary review. Do agree, we have lot of loadable interfaces, and I think we are in the way of making them on-demand (if possible) loadable modules.

Since we're planning on having loadable modules become the new normal, I
think it might be better to take 'Plugin' off the erasure coding classes
than to add it to all the others.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
