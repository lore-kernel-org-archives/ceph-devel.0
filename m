From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 08:42:32 -0700
Message-ID: <CABBk=J8o83Srortoe_ouR3jZX7ObtgZ+yEhez5Cz24o-2EK2jw@mail.gmail.com>
References: <loom.20130417T164538-81@post.gmane.org>
	<CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com>
	<loom.20130417T170632-546@post.gmane.org>
	<CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com>
	<loom.20130417T172954-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:33906 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965236Ab3DQPmd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 11:42:33 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so323874iag.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 08:42:32 -0700 (PDT)
In-Reply-To: <loom.20130417T172954-546@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: proguest <proguest1942@hotmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 17, 2013 at 8:33 AM, proguest <proguest1942@hotmail.com> wrote:
> Yehuda Sadeh <yehuda <at> inktank.com> writes:
>
>>
>> On Wed, Apr 17, 2013 at 8:13 AM, proguest <proguest1942 <at> hotmail.com>
> wrote:
>> > Yehuda Sadeh <yehuda <at> inktank.com> writes:
>> >
>> >>
>> >> Hard to know without additional info. It looks though as you might
>> >> have apache config issues (if you're using apache).
>> >>
>> >> Yehuda
>> > hi Yehuda
>> >
>> > thanks for replied me.
>> > It's only stardard setting with radosgw document.
>> > here's /etc/apache2/httpd.conf  only 1 line
>> >
>> > ServerName node74
>> >
>> > and here's /etc/apache2/sites-enabled  (just follow the website)
>>
>> is that the actual file name, or is that the directory where this
>> config file resides? do you have by any chance another default web
>> site set up under sites-enabled? did you restart apache after
>> configuring?
> I missed. It's /etc/apache2/sites-enabled/rgw.conf
> The document said
> #sudo a2ensite rgw.conf
> #sudo a2dissite default
> so there's only one configure in sites-enabled
>
did you restart apache after reconfiguring it?
