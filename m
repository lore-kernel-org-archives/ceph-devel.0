From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Rbd map failure in 3.16.0-55
Date: Sat, 12 Dec 2015 19:56:24 +0100
Message-ID: <CAOi1vP_hjcp4rs+hZRHekVjmoWK7U0T60Gbx1WjXfcbwf9hu7A@mail.gmail.com>
References: <BLUPR0201MB1908E516F6CE6529654476ECE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
	<CAOi1vP9=szuwrgLjaqXa9Pq6CrwLhKu-J0D4_xCQQi_h_-VhYQ@mail.gmail.com>
	<CO1PR02MB2085A0DBA135C58BFB94441F4EB0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33321 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbLLS4Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Dec 2015 13:56:25 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so12870443wml.0
        for <ceph-devel@vger.kernel.org>; Sat, 12 Dec 2015 10:56:25 -0800 (PST)
In-Reply-To: <CO1PR02MB2085A0DBA135C58BFB94441F4EB0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Varada Kari <Varada.Kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Dec 12, 2015 at 6:42 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Ilya,
> If we map with 'nocrc' would that help ?

No, it will disable data crcs, header and middle crcs will still be
checked.  The header/data separation in userspace is fairly new, if
that's something you care about, I can port it for 4.5 - it should be
trivial enough.

Thanks,

                Ilya
