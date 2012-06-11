From: Florian Haas <florian@hastexo.com>
Subject: Re: radosgw-admin: mildly confusing man page and usage message
Date: Mon, 11 Jun 2012 23:57:45 +0200
Message-ID: <4FD669D9.20702@hastexo.com>
References: <4FD664BA.6040801@hastexo.com> <CAC-hyiHRR9dvtniK47L9aF9dWbUB8KLqNi0a7wdU9gb_Ka140w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40212 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2FKV5u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 17:57:50 -0400
Received: by wgbdr13 with SMTP id dr13so3739027wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 14:57:48 -0700 (PDT)
In-Reply-To: <CAC-hyiHRR9dvtniK47L9aF9dWbUB8KLqNi0a7wdU9gb_Ka140w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/11/12 23:39, Yehuda Sadeh wrote:
>> If one of the Ceph guys could provide a quick comment on this, I can
>> send a patch to the man page RST. Thanks.
>>
> 
> Minimum required to create a user:
> 
> radosgw-admin user create --uid=<user id> --display-name=<display name>
> 
> The user id is actually a user 'account' name, not necessarily a
> numeric value. The email param is optional.

Thanks. https://github.com/ceph/ceph/pull/13

Cheers,
Florian
