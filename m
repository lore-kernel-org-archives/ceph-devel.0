From: kefu chai <tchaikov@gmail.com>
Subject: Re: subpackages for mgr modules
Date: Sat, 20 May 2017 08:24:57 +0800
Message-ID: <CAJE9aON-0F3u-OJW=_y0FfFaFx0KOjmCq4B6oFF9kYmQ3Lehjw@mail.gmail.com>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com> <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33015 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbdETAY7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 20:24:59 -0400
Received: by mail-vk0-f41.google.com with SMTP id x71so19871700vkd.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 17:24:58 -0700 (PDT)
In-Reply-To: <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, May 20, 2017 at 2:25 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Fri, May 19, 2017 at 12:19 AM, Tim Serong <tserong@suse.com> wrote:
>> We can't have mgr just load everything that exists (someone might want
>> to disable some modules, without necessarily uninstalling them).

it does not. user can always enable/disable a plugin using "mgr_modules", right?

>
> I'm curious why not?
>
> Ceph is already hard to configure, and "install to enable / uninstall
> to disable" would make it simpler to use.


i agree, if he/she wants to disable it, he/she could just uninstall
the plugin. actually, i am planning to split the dashboard into a
separated package. so for example, mgr does not need to depend on
cherrypy.

>
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
