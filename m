From: Henrik Korkuc <lists@kirneh.eu>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Thu, 17 Aug 2017 10:45:28 +0300
Message-ID: <0412504e-90c1-c408-b9c4-3cdee6cfe6ad@kirneh.eu>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com>
 <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
 <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
 <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
 <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM>
 <a6a7dd77-8b36-b2fb-183a-ecce43f3b8d7@redhat.com>
 <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.syseng.pro ([37.48.90.241]:59308 "EHLO alpha.syseng.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752588AbdHQHwo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Aug 2017 03:52:44 -0400
In-Reply-To: <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 17-08-17 04:02, Kamble, Nitin A wrote:
>
> On 8/16/17, 4:18 PM, "ceph-devel-owner@vger.kernel.org on behalf of Dan Mick" <ceph-devel-owner@vger.kernel.org on behalf of dmick@redhat.com> wrote:
>
>      On 08/16/2017 04:01 PM, Kamble, Nitin A wrote:
>      > After upgrading all the ceph nodes to v12.1.4 I see that OSD versions are still shown as older version.
>      > # ceph versions
>      > {
>      >     "mon": {
>      >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 1
>      >     },
>      >     "mgr": {
>      >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 1
>      >     },
>      >     "osd": {
>      >         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50
>      >     },
>      >     "mds": {
>      >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 1
>      >     },
>      >     "overall": {
>      >         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50,
>      >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 3
>      >     }
>      > }
>      >
>      >
>      > # ceph-osd --version
>      > ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>      >
>      > Why is it showing old 12.1.0 version for the 50 osds, while all the nodes show ceph osd version as 12.1.4?
>      
>      You didn't say you restarted the osds.  Did you?
>
> Yes, I did restart them, and that too more than once.
can you check what ceph-osd --version reports on one of affected hosts? 
Also "ceph daemon osd.OSD_NUM_ON_HOST version"? And "ps aux |grep 
ceph-osd" to check OSD start time, just in case
>
>      --
>      Dan Mick
>      Red Hat, Inc.
>      Ceph docs: http://ceph.com/docs
>      --
>      To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>      the body of a message to majordomo@vger.kernel.org
>      More majordomo info at  http://vger.kernel.org/majordomo-info.html
>      
>
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!tml=


