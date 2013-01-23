From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 10:06:42 -0800
Message-ID: <CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:45797 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab3AWSGn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 13:06:43 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so4108917iaj.20
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 10:06:42 -0800 (PST)
In-Reply-To: <CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 23, 2013 at 10:02 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
>> try
>> # radosgw -n client radosgw.gateway
>
> Still doesn't work.

whoops, was missing a period there.

>
> # radosgw -n client radosgw.gateway
> error parsing 'client': expected string of the form TYPE.ID, valid
> types are: auth, mon, osd, mds, client
>
> # radosgw -n client.radosgw.gateway

That's one step further. What does the log show now?

Yehuda
