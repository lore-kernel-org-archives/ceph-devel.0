From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: crushmap visualisation
Date: Sun, 26 Feb 2017 11:48:08 +0100
Message-ID: <20170226104808.2qexvszwtmhm4koj@jf_suse_laptop>
References: <b2a72da4-b8aa-4d64-4bd2-374f25aeb681@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:55123 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdBZKt0 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Sun, 26 Feb 2017 05:49:26 -0500
Content-Disposition: inline
In-Reply-To: <b2a72da4-b8aa-4d64-4bd2-374f25aeb681@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Feb 26, 2017 at 10:51:12AM +0100, Loic Dachary wrote:
>Hi,
>
>Is there something to visualize a crushmap ? It looks like balloon trees and hierarchical bundling (see fig 13a in http://www.aviz.fr/wiki/uploads/Teaching2014/bundles_infovis.pdf) would be a good match. It could show, for instance, where objects move when the crushmap changes. But I've never thought about it before and maybe someone already has an answer to the question ;-)
>
>Cheers
Hi Loic,
Openattic has a crushmap visualisation. For an example see the demo instance 
(credentials are openattic/openattic): 
https://demo.openattic.org/openattic/#/ceph/crushmap
Its called editor in the demo but I'm not certain about the status of the 
editing capabilities.
>-- 
>Loïc Dachary, Artisan Logiciel Libre
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
