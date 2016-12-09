From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: [SUGGESTION]Should we provide a method to get git's branch name
 and commit tag?
Date: Fri, 9 Dec 2016 14:00:16 +0100
Message-ID: <0c26cdfe-ce5b-e12c-deaa-f32c1678e3e6@suse.cz>
References: <CACKY0b8Y1JFqu-qD-XXUx9ZtLitfFuEaSqamEGK4fD=SspoziA@mail.gmail.com>
 <alpine.DEB.2.11.1612071431140.22485@piezo.novalocal>
 <CACKY0b8TLkBroE0cw8uvF=TATnqa99kZnQSKtmrS=-CpWHkZYw@mail.gmail.com>
 <CACJqLyba68pAOVcjO_rOPV8Vyb_GYOV2a5Uhk3GRzjWr0_KZPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49451 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbcLINAc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Dec 2016 08:00:32 -0500
In-Reply-To: <CACJqLyba68pAOVcjO_rOPV8Vyb_GYOV2a5Uhk3GRzjWr0_KZPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> # ceph daemon /var/run/ceph/ceph-osd.32.asok version
>> {"version":"0.94.9-166-gbe32c81"}
>>
>> Is "gbe32c81" git's commit?
>
> be32c81

The string "0.94.9-166-gbe32c81" is coming from "git describe". Check 
out "man git describe" for more info.

Nathan
