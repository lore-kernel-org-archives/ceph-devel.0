From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Broken links in Ceph documentation
Date: Thu, 23 Mar 2017 13:21:29 +0100
Message-ID: <a81ccd21-715c-adc8-2e2f-1797a4147a18@suse.cz>
References: <CACKY0b8-rq-R0Sun9Mxfk3ogtA-YMF26HMWUJj0xEZ__9_Z9YQ@mail.gmail.com>
 <CAJE9aONJQ7nAO3m+z8zyx_7qnkacU_cHPQcUMWq-5QLrA80xjQ@mail.gmail.com>
 <CACKY0b8y8CFXGJEcHqjM8D+XRSBKs4Ag5k01QWwpY78ZjjU4Dw@mail.gmail.com>
 <CAJE9aONcAndHg-TXjzWyaS=i=xw+X7uX4kRMw=PLKjUjsjXUvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38299 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbdCWMVf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 08:21:35 -0400
In-Reply-To: <CAJE9aONcAndHg-TXjzWyaS=i=xw+X7uX4kRMw=PLKjUjsjXUvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, liuchang0812 <liuchang0812@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> BTW, there are a lot of `http://github.com/ceph/ceph/pull/xxxx` links.
>> It should be `https://github.com/ceph/ceph/pull/xxx` in our
>> ReleaseNotes.rst
>
> they are redirected to https://github.com/ceph/ceph/pull/xyz, so i
> guess it's fine?

"git clone http://github.com/ceph/ceph" also works fine.

Also, I am not aware of any security risk that is addressed by using 
SSL. Ceph is FLOSS, after all. Why encrypt the HTTP traffic?

Nathan
