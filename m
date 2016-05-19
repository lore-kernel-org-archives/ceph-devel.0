From: John Spray <jspray@redhat.com>
Subject: Re: Update on ceph-mgr
Date: Thu, 19 May 2016 12:40:48 +0100
Message-ID: <CALe9h7fi0vW6eEHcxPNG6rkKi9-CHvi4GnvM4VLuc0tJNw98Tg@mail.gmail.com>
References: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
 <573DA0DB.30203@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35332 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbcESLlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 07:41:12 -0400
Received: by mail-oi0-f47.google.com with SMTP id x19so123687157oix.2
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 04:41:11 -0700 (PDT)
In-Reply-To: <573DA0DB.30203@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, May 19, 2016 at 12:17 PM, Tim Serong <tserong@suse.com> wrote:
> On 05/18/2016 09:02 PM, John Spray wrote:
>> Hi all,
>>
>> For those who are interested, I wanted to give a quick update on the
>> recently-started ceph-mgr work.  This is all still very changeable,
>> but now that some code exists I'm putting it out there.
>>
>> Firstly, here it is: https://github.com/jcsp/ceph/tree/wip-ceph-mgr
>>
>> [...]
>>
>> To play with this:
>>  1. Build your tree with cmake
>>  2. make ceph-mgr
>>  3. CALAMARI_CONFIG=<whereever>/ceph/src/pybind/mgr/calamari.conf
>> PYTHONPATH=env/lib/python2.7/site-packages bin/ceph-mgr -f
>>  4. Point your browser at e.g.
>> http://localhost:8002/api/v2/cluster/osd and witness that you get
>> calamari-like API output
>
> Just for fun, I decided to play.  I built from a clone of your
> wip-ceph-mgr branch, then grabbed a ceph.conf and admin keyring from an
> existing Jewel cluster, dumped them in build/, and ran:
>
> PYTHONPATH=../src/pybind/mgr
> CALAMARI_CONFIG=../src/pybind/mgr/calamari.conf ./bin/ceph-mgr
> --keyring=./ceph.client.admin.keyring --log-file=client.log
>
> This immediately aborted with an assertion failure:
>
>   /ceph/src/mgr/Mgr.cc: 241: FAILED assert(mds_cmd.r == 0)

Yeah, you're not in general going to be able to run this against an
older-versioned Ceph cluster; there are already mon changes (such as
improving the metadata commands) and there will also be more extensive
additions to all the services to enable them to talk to the mgr.  This
is going to be new functionality all around, as opposed to a new thing
that can sit on older clusters.

> I suspect the "mds metadata" command might want an MDS name.  Throwing
> caution to the wind I commented out that assert, and the mon_cmd.r
> assert as well (see attached patch), and got a bit further, but then it
> failed with:
>
>   ImportError: No module named rest_framework
>
> TL;DR: I had to install pythond-datetime, django 1.8 and
> djangorestframework.  The latter I let be the latest version available
> via `pip install` (3.3.3).
>
> I had earlier tried Django 1.9, which I randomly happened to have
> installed, but that failed with:
>
> RuntimeError(u"Model class django.contrib.auth.models.Permission doesn't
> declare an explicit app_label and isn't in an application in
> INSTALLED_APPS.",)
>
> (Django 1.6 is no good either, BTW: AttributeError: 'module' object has
> no attribute 'UUIDField')
>
> Anyway, after all that, I can in fact get a nice looking chunk of JSON
> out of http://localhost:8002/api/v2/cluster/osd :)

Awesome!

John

>
> Regards,
>
> Tim
> --
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
