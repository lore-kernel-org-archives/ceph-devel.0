From: Wido den Hollander <wido@42on.com>
Subject: Re: Blocked / Slow requests in health JSON from Mon/Mgr
Date: Mon, 27 Nov 2017 13:59:14 +0100 (CET)
Message-ID: <1511744902.5447.1511787555005@ox.pcextreme.nl>
References: <666139692.5433.1511778561280@ox.pcextreme.nl>
 <CALe9h7ddDDdW=SwJQG3_C8EUXy35191WwcngYFXBHheOWU7L1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se01-out.mail.pcextreme.nl ([185.66.251.200]:52859 "EHLO
        se01-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752798AbdK0NAA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Nov 2017 08:00:00 -0500
In-Reply-To: <CALe9h7ddDDdW=SwJQG3_C8EUXy35191WwcngYFXBHheOWU7L1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 27 november 2017 om 12:19 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Mon, Nov 27, 2017 at 10:29 AM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > For the Zabbix plugin for the Mgr I wanted to report the amount of block and/or slow requests the cluster is experiencing.
> >
> > There is no item with a int value in the JSON returned by the Monitors.
> >
> > What would be the easiest way to obtain these values in a Mgr Module?
> >
> > Or would we need to expand the JSON the MON reports?
> >
> > I'd like to make a trigger in Zabbix that if num slow requests is > X a admin is alerted.
> >
> > Right now you would have to parse a string which isn't very stable.
> 
> Kefu has been working on the health checks for slow requests:
> https://github.com/ceph/ceph/pull/18614
> https://github.com/ceph/ceph/pull/19114
> 
> Currently, health checks are very string-ish, but I would really like
> them to have more machine-readable stuff (i.e. expand the
> health_check_t structure with a generic map to store json-encodable
> metadata), and populate that in the same places we generate strings
> (e.g. in this instance where PGMap generates the
> REQUEST_SLOW/REQUEST_STUCK health checks).
> 

Good! That would be nice, something like this in a JSON:

{
    "block_requests": 13,
    "slow_requests": 35
}

The Zabbix module could pick this values up and send them to Zabbix for further processing.

> BTW, I'm curious about the use case for thresholding slow requests on
> the number of slow requests: wouldn't you want to alert the admin even
> if there was only one?  If there are false positives then maybe
> mon_osd_warn_op_age is the thing to adjust
> 

Well, not sure. You probably want to alert if one or more occur.

I would just want a integer in a JSON somewhere and use it in Zabbix for graphing and alerting.

Wido

> John
