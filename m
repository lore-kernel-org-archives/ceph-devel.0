From: John Spray <jspray@redhat.com>
Subject: Re: [GSOC] ceph-mgr: Cluster Status Dashboard
Date: Sun, 21 May 2017 23:39:53 +0100
Message-ID: <CALe9h7d0mWZoRCJqnQSbtkRH-Rn8ikkxD3TpdWByzn-=zYpHPQ@mail.gmail.com>
References: <CA+b5B08BdnpZvbnWS+ocr2oObG4moc0nGibGwm6Taq9Eh=46wg@mail.gmail.com>
 <CALe9h7esz4MquzA6ZqCniOj8jb=j+7QdhnSkLTj+2d9HCyYtFw@mail.gmail.com>
 <CA+b5B089q0sbcF07Di2-4JroUjZNNekvAa2SeOQvWgB7X8wqaQ@mail.gmail.com> <CAEYCsVLV7zA+9-9D-LGe=Myub4Qf49fUDdMOdDrA7DD6411DDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35296 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756817AbdEUWkP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 21 May 2017 18:40:15 -0400
Received: by mail-wm0-f47.google.com with SMTP id b84so278960177wmh.0
        for <ceph-devel@vger.kernel.org>; Sun, 21 May 2017 15:40:14 -0700 (PDT)
In-Reply-To: <CAEYCsVLV7zA+9-9D-LGe=Myub4Qf49fUDdMOdDrA7DD6411DDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: saumay agrawal <saumay.agrawal@gmail.com>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 19, 2017 at 8:18 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> FWIW, we have our home-made dashboard  in production including
> a) Ceph cluster status  (Healthy, PG, pool, space , IO statistisc by pool)
> b) Hardware metrics on ceph nodes(cpu, memory ,disk iostat, network)
> c) perf dump via admin socket, most importantly , commit_latency and
> apply_latency for OSDs.
> d) user facing performance , mostly latency,  collected by periodly
> running some test IO on top of the cluster.
>
> The data are come from ceph itself(a) , prometheus agent(b) , hacked
> script from "ceph daemonperf" (c), and home mode monitoring code(d).
> Dashboard is Grafana on top of prometheus, it is easy to use and easy
> to customized.
>
> Wondering if Grafana or whatever other existing dashboard framework
> could also be a choice for dashboard? Just ceph-mgr collect all the
> informations and dashboard frontend consume data from ceph-mgr via
> API?

Grafana and Prometheus are great, and an effort to put together a
standard configuration that we could ship with Ceph would be a very
positive thing.

"Dashboard" means different things to different people -- the goal of
the mgr module we have here is initially to give people similar
information to "ceph status" but in an easier to consume form.  Tools
for plotting and exploring time series data are kind of a separate
(also important) thing, which is also often called "dashboard" :-)

I say that not to discourage anyone, but because I've found
historically that the larger task of doing an integrated TSDB solution
has sometimes held us back from delivering the bare basics of a web
dashboard that tells you your cluster health, and I'm keen to make
sure that we don't let the complicated parts hold us back from
delivering the simpler parts quickly.

John

>
> Xiaoxi
>
> 2017-05-13 18:37 GMT+08:00 saumay agrawal <saumay.agrawal@gmail.com>:
>> On Sat, May 13, 2017 at 1:35 PM, John Spray <jspray@redhat.com> wrote:
>>> On Sat, May 13, 2017 at 6:06 AM, saumay agrawal
>>> <saumay.agrawal@gmail.com> wrote:
>>>> Hi Kefu,
>>>>
>>>> I apologize for the late reply.
>>>>
>>>> I have been looking into the PR you mentioned earlier
>>>> https://github.com/ceph/ceph/pull/14946 . I have also explored the
>>>> Calamari Dashboard in the past few days. I have some queries.
>>>>
>>>> I guess since Calamari Dashboard already does the job of visualizing
>>>> the statistics of a Ceph cluster (health, OSDs, MONs, pools, IOPS,
>>>> space utilization etc), we would primarily be improving on its UI/UX,
>>>> that is to say the visualization portion and some other
>>>> functionalities. Please do correct me if I am wrong in this.
>>>>
>>>> Moreover, Calamari Dashboard is made up of Calamari Server (backend)
>>>> and Calamari Clients (frontend).
>>>>
>>>> I found out that Calamari Server uses a new REST API instead of being
>>>> based upon the CEPH REST API. Will I be working on improving this new
>>>> REST API?
>>>>
>>>> Moreover, Calamari Server is written in Django and
>>>> django-rest-framework. However in the prototype of the dashboard
>>>> mentioned in the PR above, I could find that the dashboard is using
>>>> CherryPy too. CherryPy is a minimalist framework which is good for
>>>> prototyping and makes it very easy. Meanwhile Django is more of a
>>>> complete web application stack. So will we be using a single
>>>> technology primarily, or a combination of both?
>>>
>>> Welcome!
>>>
>>
>> Thanks, John. :)
>>
>>> Don't worry about any of the Django or REST stuff.  Django is being
>>> dropped from everything because the maintainers of downstream
>>> (distribution) packages are highly opposed to supporting it as a
>>> dependency.  The REST part is not needed when the dashboard is built
>>> as a mgr module, because as a mgr module is has direct access to the
>>> Ceph state.
>>>
>>
>> As you say. Can you point out any other areas of Ceph that I should
>> explore thoroughly for this project? Also, I would be glad if you
>> could share any kind of technologies that I need to be familiar with
>> (other than HTML, CSS, JS etc). For example, I'm looking into CherryPy
>> these days. It will help me to pick up things more easily if I know
>> the tech you are planning to use for the dashboard.
>>
>>>> Last thing I want to ask is for what kinds of things I should be
>>>> contacting you and for what kind of things I should be contacting
>>>> John? Since John is my mentor on this project and I can see him
>>>> working on most of the Dashboard portion on GitHub, I presume for any
>>>> dashboard related issue I should contact him. And also to whom should
>>>> I send the weekly report of my progress on my project?
>>>
>>> I think I'm supposed to be a co-mentor (whatever that means :-) ) and
>>> Kefu is your primary point of contact.  I'm always happy to provide
>>> opinions though of course.
>>>
>>> John
>>>
>>>
>>>> Regards,
>>>> Saumay.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
