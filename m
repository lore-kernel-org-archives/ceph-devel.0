From: John Spray <jspray@redhat.com>
Subject: =?UTF-8?B?UmU6IFtjZXBoLXVzZXJzXSDnrZTlpI06IOetlOWkjTogaG93IHRvIHNlZSBmaWxlIG9iag==?=
	=?UTF-8?B?ZWN0LW1hcHBpbmdzIGZvciBjZXBoZnVzZSBjbGllbnQ=?=
Date: Mon, 7 Dec 2015 10:34:34 +0000
Message-ID: <CALe9h7f7JSFhyHotCwYC_HRTthAX0mAtukkr8fLr-ud=9g=JFA@mail.gmail.com>
References: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E8A52@H3CMLB12-EX.srv.huawei-3com.com>
 <CAAM7YAkdHJ0jCWDhWBRX2v7tCiXxw7ZM3T39Lk5=6XHNCo2EOA@mail.gmail.com>
 <F075EA5A8A3F8045B2A81359C8B5B07C5E3E9B12@H3CMLB12-EX.srv.huawei-3com.com>
 <CAAM7YA=bcqDfh0GVvxVXOdo0x239LkP+Z9rQ3txdYOJ9_Zo3QQ@mail.gmail.com> <F075EA5A8A3F8045B2A81359C8B5B07C5E3E9BFD@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36292 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096AbbLGKez convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 05:34:55 -0500
Received: by lbblt2 with SMTP id lt2so57575784lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 02:34:54 -0800 (PST)
In-Reply-To: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E9BFD@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wuxiangwei <wuxiangwei@h3c.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, Dec 7, 2015 at 9:13 AM, Wuxiangwei <wuxiangwei@h3c.com> wrote:
>
> it looks simple if everything stays as its default value. However, we do want to change the stripe unit size and stripe count to achieve possible higher performance. If so, it would be too troublesome to manually do the calculation every time when we want to locate a given offset(and maybe a certain interval). The 'cephfs map' and 'cephfs show_location' can provide good information as we want, but sadly not for ceph-fuse. That's why I ask for a similar tool.

If you are interested in writing this, you could look at
Client::get_file_stripe_address and Striper::file_to_extents.
Currently in libcephfs we expose methods for getting the OSDs relevant
to a particular file, in case something like hadoop wants to exploit
locality, but we don't expose the intermediate knowledge of the object
names.

I am curious about why you need this?

John
