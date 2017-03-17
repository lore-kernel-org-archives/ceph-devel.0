From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: why do we delete target in RGWGetObjLayout constructed function?
Date: Fri, 17 Mar 2017 18:08:39 +0800
Message-ID: <CACKY0b8JyVQDpzA=fQEVx8+fBg+Rb7d_jFeSP7HjwUj3EY0Prw@mail.gmail.com>
References: <CACKY0b_snoqrOhhXGFjZmypYx+zByyxNihjahRJQBtse3_Aw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34042 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdCQKIm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Mar 2017 06:08:42 -0400
Received: by mail-yw0-f181.google.com with SMTP id p77so49813166ywg.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Mar 2017 03:08:41 -0700 (PDT)
In-Reply-To: <CACKY0b_snoqrOhhXGFjZmypYx+zByyxNihjahRJQBtse3_Aw3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I crated a PR: https://github.com/ceph/ceph/pull/14014

2017-03-17 17:58 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
> I saw this problem when i read RGW source code. It seems that that
> `delete` a nullptr will segment fault.
>
> code[1]:
>
> class RGWGetObjLayout : public RGWOp {
>    protected:
>         RGWRados::Object *target{nullptr};
>         RGWObjManifest *manifest{nullptr};
>         rgw_raw_obj head_obj;
>     public:
>          RGWGetObjLayout() {
>              delete target;
>    }
>
>
> [1]. https://github.com/ceph/ceph/blob/master/src/rgw/rgw_op.h#L1777
