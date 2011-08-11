From: Samuel Just <samuelj@hq.newdream.net>
Subject: Doxygen
Date: Thu, 11 Aug 2011 15:25:27 -0700
Message-ID: <4E4456D7.3080408@hq.newdream.net>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49905 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab1HKWZJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2011 18:25:09 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 414B4C064
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2011 15:27:04 -0700 (PDT)
Received: from [192.168.107.148] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 3DB3CC063
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2011 15:27:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

(Sorry for the repeat, should have sent to the list)

I spoke to Sage for a bit about documentation.  Here is what we ended up 
with:

/**
  * Brief class comment ending with this period.  Not part of the brief 
comment.
  *
  * Details here.
  * Etc.
  */
class Foo {
     /// Comment for the member following.
     int member;

     /** Brief function comment up to this period.
      *
      * More details.
      * @param count [in] How many.
      * @param retval [out] Returned string.
      * @return Error Code
      */
     int gen_foo_string(int count, string *reval);

     /** Brief function comment again.
       * @return Error Code
       */
     int gen_foo_string2(int count,        ///< [in] How many.
                                    string *retval); ///< [out] Returned 
String.
};

Doxygen allows a variety of commenting styles, so it probably makes 
sense to standardise on one.  The above is based on the Javadoc style.  
/** or /// indicate the beginning of a Doxygen comment.  Parameters can 
either be documented before the function declaration (as in 
gen_foo_string) or inline with the parameters as in gen_foo_string2.  
The latter approach seems to have two benefits.  First, that it's 
difficult to change the parameters without changing the documentation.  
Second, that you don't need to duplicate the parameter name or add 
@param.  However, longer comments become unwieldy.  I suggest we use the 
gen_foo_string2 style when it's convenient and the gen_foo_string style 
when we need longer comments.

Questions?  Comments?  Criticisms?
-Sam
