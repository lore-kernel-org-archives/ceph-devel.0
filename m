From: Casey Bodley <cbodley@redhat.com>
Subject: Fwd: [boost] [review][beast] Beast Review Results
Date: Thu, 20 Jul 2017 09:40:54 -0400
Message-ID: <f91dd912-23fa-69fa-aee7-872cbe97c044@redhat.com>
References: <939e482b-254e-3212-3edc-57af362e58d6@ciere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:37074 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934128AbdGTNk5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jul 2017 09:40:57 -0400
Received: by mail-qt0-f170.google.com with SMTP id m7so22901054qtm.4
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jul 2017 06:40:57 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id o20sm1855684qtc.23.2017.07.20.06.40.54
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 06:40:55 -0700 (PDT)
In-Reply-To: <939e482b-254e-3212-3edc-57af362e58d6@ciere.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

This is good news for radosgw, which has been using Beast (an http 
protocol library on top of boost::asio) for an experimental frontend. 
The boost formal review took place earlier this month, and its 
acceptance was just announced.



-------- Forwarded Message --------
Subject: 	[boost] [review][beast] Beast Review Results
Date: 	Thu, 20 Jul 2017 00:56:15 -0700
From: 	Michael Caisse via Boost <boost@lists.boost.org>
Reply-To: 	boost@lists.boost.org
To: 	boost <boost@lists.boost.org>
CC: 	Michael Caisse <mcaisse-lists@ciere.com>



In an effort to get you all to just read this announcement sequentially,
I will start with the result:

	Beast is ACCEPTED into Boost without conditions

The entire community is served when the Boost review process works well
and I would like to personally thank each of you who took your valuable
time and worked to make Boost better. We had 21 formal reviews submitted
from a demographic that included both seasoned participants and
first-time reviewers. It is gratifying to have such participation for
what some might see as a niche library.

   * Thank you Vinnie for your effort to assemble a high-quality package
     for review and for your responsiveness on the mail-lists. GitHub,
     and Slack.
   * Thank you to the individuals that submitted their first Boost
     review.
   * Thank you to the veteran contributors and authors for continuing to
     devote energy to the community.

I found the discussion surrounding the library beneficial and I know
that Vinnie walked away with actionable items to improve Beast.

--------------------
The Stats:
--------------------

While the review process is not exactly tallying up votes and casting a
verdict, we can gain some insight of the general, gross-scale opinion of
the library.

Official reviews were received from:

    Reviewer               Accept | Reject
------------------------------------------
  * Zach Laine           :   X
  * Nik Bougalis         :   X
  * Artyom Beilis        :            X
  * Peter Dimov          :   X
  * Klemens Morgenstern  :   X
  * Glen Fernades        :   X
  * Marcel Ebmer         :   X
  * Scott Determan       :   X
  * Stanislav Karchebnyy :   X
  * Michael Larson       :   X
  * Vadim Zeitlin        :   X
  * Jared Wyles          :   X
  * Niall Douglas        :   X
  * Barrett Adair        :   X
  * Gyorgy Szekely       :   X
  * Daniela Engert       :   X
  * Jens Weller          :   X
  * Phil Endecott        :            X
  * Bjorn Reese          :            X
  * Rüdiger Berlich      :   X
  * Christopher Kohlhoff :   X



Most of the reviewers agreed on the inclusion of Beast into Boost and at
the same time that Beast isn't a great name for the library. (Just say
Boost.Beast 10-times-fast). Vinnie has a FAQ item discussing the name
and his continuing use is deliberate. He has heard the petitions to
change and weighed them.


--------------------
Concerns:
--------------------

A variety of concerns and comments were made during the review. An
impressive number of items were addressed in code or documentation
during the review period itself.

Some of the stated concern for rejection included:

* Too many templates
* Run-time polymorphism / OO would be better.

* Library scope is too small and provides no real value to users -

   This is clearly one of those value judgements and for some users the
   not-in-scope nature of Beast made the feature set not compelling
   enough to use or have as a Boost library. Other users spent time
   converting existing projects to use Beast. This included projects
   previously running POCO, libcurl, and homegrown solutions.

   Beast has existing commercial and open-source users. The library
   clearly meets the needs of some users.

* Premature optimization
* Security concerns

* Poor support for HTTP chunking -

   Vinnie proposed and then later made changes addressing the chunking
   concerns. Unfortunately, the reviewer with the complaint did not
   respond to multiple requests for feedback.

* Licensing -

   Four files have dual licenses (BSL and another). Boost's legal
   counsel is reviewing the situation and we hope to have guidance by
   the end of this week. I have not placed a condition on the
   acceptance of Beast based on the legal feedback because Vinnie knows
   licensing issues must be remedied before the repository is merged
   into Boost.

--------------------
The Upsides:
--------------------

There were lots of great things said about the Beast package. Some of
these include:

* Great documentation
* High quality implementation.
* Thorough test suites
* Already being used by commercial entities and others
* Lots of successful real-life conversions of existing clients/servers
* Extremely responsive developer (do you sleep Vinnie?)


--------------------
An Author as much as a Library:
--------------------

Accepting a library into Boost is also accepting an author. Boost
authors have enormous latitude in the control and modifications of their
libraries. Vinnie has shown dedication to addressing issues, listening
to constructive input, making changes when appropriate, and protecting
his vision of what the Beast is. I believe Vinnie will serve the
community well as a contributor.


--------------------
Final Thoughts:
--------------------

Reviews are hard. It is hard to have your work torn apart and remain
considerate. It is hard to repeat answers to previously asked questions.
It is hard to explain specific use-cases and why it is important a
library supports them. It is difficult to critique a large body of work.
It is hard to stick with conversations to make overall improvements.

I was impressed with the participants in the review. We are all
opinionated and passionate -- likely a prerequisite to being part of the
Boost community. Thank you all for making Boost better.

I'm looking forward to seeing additional libraries and application built
with Beast.


-- 
Michael Caisse
Ciere Consulting
ciere.com

_______________________________________________
Unsubscribe & other changes: http://lists.boost.org/mailman/listinfo.cgi/boost

