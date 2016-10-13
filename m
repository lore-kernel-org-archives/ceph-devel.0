From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-disk]how to specific cluster name when active an osd?
Date: Thu, 13 Oct 2016 13:36:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610131335410.19763@piezo.us.to>
References: <CAKZcxgdYG__w1f_YEu0fcO8CpRWejBnadRP-giVLY7MC7QYsEw@mail.gmail.com> <CALZt5jzzjpi07dLXc9636zeMwN4b9Qmo_JBnN-3ePvZqqO72OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-669944520-1476365766=:19763"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48995 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbcJMNgX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 09:36:23 -0400
In-Reply-To: <CALZt5jzzjpi07dLXc9636zeMwN4b9Qmo_JBnN-3ePvZqqO72OA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: Jaze Lee <jazeltq@gmail.com>, Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-669944520-1476365766=:19763
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 13 Oct 2016, Ning Yao wrote:
> Yeah,
> 
> If we want to use a different cluster name instead of the default
> cluster name 'ceph'. we need to modify the ceph-osd@.service file to
> make sure the cluster name is what we use.
> Any ideas to solve the issue under systemd?  @Loic

I believe you can set the cluster name in /etc/default/ceph or 
/etc/sysconfig/ceph, but I'm not sure if it's tested.

sage


> Regards
> Ning Yao
> 
> 
> 2016-10-12 15:18 GMT+08:00 Jaze Lee <jazeltq@gmail.com>:
> > If using systemd, we can not specific cluster name when active an osd...
> > Is there a way to send in the ENV CLUSTER by systemctl?
> >
> >
> > Thank a lot
> >
> > --
> > 谦谦君子
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-669944520-1476365766=:19763--
