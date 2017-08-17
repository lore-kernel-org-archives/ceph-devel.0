From: David Zafman <dzafman@redhat.com>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Thu, 17 Aug 2017 13:50:17 -0700
Message-ID: <dcbb44f0-c1e9-2acf-133c-fe7dbfcdcd51@redhat.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com>
 <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
 <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
 <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
 <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM>
 <a6a7dd77-8b36-b2fb-183a-ecce43f3b8d7@redhat.com>
 <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM>
 <238bc116-e706-031e-ab11-06e2383a9a04@redhat.com>
 <469DEC9D-7E3D-49C5-8AE6-71877039B3AC@TERADATA.COM>
 <CAKPXa=ZPeMST83ekgUkYbO5yz-ic3q_guY__0=tY7PSwmk-4YA@mail.gmail.com>
 <1B0B99FE-C6D5-455E-B8B7-1972D9B8FD2F@TERADATA.COM>
 <00EA3786-0D39-446A-8E48-0E03D505AC51@TERADATA.COM>
 <66B27C76-0184-452F-9BC8-A91E6D6C9B60@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbdHQUuS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Aug 2017 16:50:18 -0400
In-Reply-To: <66B27C76-0184-452F-9BC8-A91E6D6C9B60@TERADATA.COM>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, Vasu Kulkarni <vakulkar@redhat.com>
Cc: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


I wouldn't run the OSDs without identifying what is going on.  I suggest 
you stop the OSD and run fsck using ceph-objectstore-tool:


ceph-objectstore-tool --data-path .... --op fsck

If you don't get any informative messages add --debug to get detail logging.


David



On 8/17/17 10:37 AM, Kamble, Nitin A wrote:
>
> On 8/17/17, 10:23 AM, "ceph-devel-owner@vger.kernel.org on behalf of Kamble, Nitin A" <ceph-devel-owner@vger.kernel.org on behalf of Nitin.Kamble@Teradata.com> wrote:
>              
>      BTW I found a workaround which is working and giving the right versions now.
>      
>      The workaround is mentioned here: https://github.com/ceph/ceph/pull/10825/files
>      
>      Basically adding this line to global section of ceph.conf resolves the issue.
>      bluestore fsck on mount = 'false'
>          
>      
>
> Still not sure why fsck failed. Can this be the reason? systemd stop/start of osd daemons does not perform umount and remount, and fsck on mounted filesystem fails.
>
>
> Thanks,
> Nitin
>
>
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!tml=

