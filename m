From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: why do we delete target in RGWGetObjLayout constructed function?
Date: Fri, 17 Mar 2017 19:11:11 +0800
Message-ID: <CACKY0b8n0p4rVCVrE_jZ+5FA41oWZKyfzSLPtt6CJ7ie-BHykQ@mail.gmail.com>
References: <CACKY0b_snoqrOhhXGFjZmypYx+zByyxNihjahRJQBtse3_Aw3A@mail.gmail.com>
 <13a064ed-c7b9-c495-ee36-246583eea4e1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35608 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdCQLTj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Mar 2017 07:19:39 -0400
Received: by mail-yw0-f169.google.com with SMTP id v198so50754639ywc.2
        for <ceph-devel@vger.kernel.org>; Fri, 17 Mar 2017 04:19:38 -0700 (PDT)
In-Reply-To: <13a064ed-c7b9-c495-ee36-246583eea4e1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jos Collin <jcollin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

yes, but target is not deleted.

2017-03-17 18:39 GMT+08:00 Jos Collin <jcollin@redhat.com>:
> No, it won't even if target = 0. As it is unused.
>
>
> On Friday 17 March 2017 03:28 PM, liuchang0812 wrote:
>
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
>
