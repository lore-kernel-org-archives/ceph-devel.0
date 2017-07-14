From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: [ceph-users] upgrade procedure to Luminous
Date: Fri, 14 Jul 2017 16:39:53 +0200
Message-ID: <20170714143953.5fyirnegj4466ljr@suse.com>
References: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de>
 <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
 <20170714142734.5aqzae7x7fmsqmmz@suse.com>
 <C7751C1D-7C11-4706-B167-D4745D058F0B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54873 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbdGNOkK (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 14 Jul 2017 10:40:10 -0400
Content-Disposition: inline
In-Reply-To: <C7751C1D-7C11-4706-B167-D4745D058F0B@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Lowe <j.michael.lowe@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On 2017-07-14T10:34:35, Mike Lowe <j.michael.lowe@gmail.com> wrote:

> Having run ceph clusters in production for the past six years and upgrading from every stable release starting with argonaut to the next, I can honestly say being careful about order of operations has not been a problem.

This requirement did not exist as a mandatory one for previous releases.

The problem is not the sunshine-all-is-good path. It's about what to do
in case of failures during the upgrade process.



-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

