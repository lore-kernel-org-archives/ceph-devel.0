From: Daniel Oliveira <doliveira@suse.com>
Subject: Cephx kerberization support
Date: Tue, 23 Aug 2016 20:34:12 -0600
Message-ID: <1472006052.10929.0.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:34070 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbcHXCec (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 23 Aug 2016 22:34:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,  

We have been *brainstorming* on how to get "Cephx kerberization
support" done. From the initial ideas: a) GSSAPI based protocol; b)
Some sort of native Krb5 Cephx support, which means a need for a Krb5
authorizer along with some channel bindings (due to ULP principals),
where the latter seems to be a good/best approach.

As this is an important topic and we would like to discuss it during
our next CDM, your ideas and interest are greatly appreciated. 

Thanks,
-Daniel 


