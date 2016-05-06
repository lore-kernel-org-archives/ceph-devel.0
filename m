From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 1/1] fs/ceph: make logical calculation functions return bool
Date: Fri, 6 May 2016 10:24:17 +0200
Message-ID: <CAOi1vP-MPvoXVuaKyXAEdW2wjLhGJANMMjyBe8_P-07nQQ4Xxw@mail.gmail.com>
References: <1458897519-19161-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
	<000801d1a766$ea55cf50$bf016df0$@cmss.chinamobile.com>
	<A377484B-D4AB-4C83-ABE5-203CBEDBB4CD@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A377484B-D4AB-4C83-ABE5-203CBEDBB4CD@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, May 6, 2016 at 9:24 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On May 6, 2016, at 15:14, Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com> wrote:
>>
>> Hi,  Yan, Viro
>>
>> Any other comments on this updated version?
>
> I have no comment for the cephfs part.
>
> Ilya, do you like the libceph part?

I'd leave off rados.h hunk - it's shared with userspace and those
functions aren't used.  The rest is fine by me.

Thanks,

                Ilya
