From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Jenkins build pestered by 'no such option:
 --disable-pip-version-check'
Date: Wed, 20 Jul 2016 09:09:21 +0200
Message-ID: <cde3c0c3-e91e-4df4-9496-a4b14c13975d@digiware.nl>
References: <b3939bd4-59c4-4820-8be2-7c087f8b7757@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25383 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbcGTHJy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jul 2016 03:09:54 -0400
In-Reply-To: <b3939bd4-59c4-4820-8be2-7c087f8b7757@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>, dang@redhat.com, Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-7-2016 08:02, Dan Mick wrote:
> ....but I guess that's also broken at the moment
> 
> Sent from Nine <http://www.9folders.com/>
> ------------------------------------------------------------------------
> *From:* Dan Mick
> *Sent:* Jul 19, 2016 8:21 PM
> *To:* Willem Jan Withagen; dang@redhat.com; Alfredo Deza
> *Cc:* Ceph Development
> *Subject:* Re: Jenkins build pestered by 'no such option:
> --disable-pip-version-check'
> 
> 
>> Well the problem is, that it is not me that has an old version of pip.
>> But this is in Jenkins and that is on the test environment where there
>> is fetched fresh very test-build.
>> I would not know how to influence this?
> 
> It looks as though one massive commit in
> https://github.com/ceph/ceph/pull/10283 included a fix that should
> resolve this.  Perhaps pull that into your branch?

That would mean that my pull contains code that is already in HEAD.
I guess that would work locally, but not during Jenkins testing.
Beter I check why I did not get it with a rebase?

--WjW


