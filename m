Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35192367F56
	for <ceph-devel@vger.kernel.org>; Fri,  6 Feb 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385152; cv=none; b=nup+dj8IMat6RI2W3tuu4869VeVq7182soTLRN3KiYIXqHvqkaKyLbHroTr25LWxcTFIhqwaM8J/cOydz5tUGAE8lfxLmKYFqN1pUHKnYl/WqWCinxYmL6RjphkrtsNivJjQMNSShUpPEoZCgNBB0gl+lPBmTji9cM8SUE1Lb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385152; c=relaxed/simple;
	bh=7jqm8TFBXjPCT0+qMbh5So+0/cmSb5NyAanWOsqG4NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HkYPuGJJ9NZ9rGbAIv8C5aeXEs454hSTveV+SQmcNBajVNQwQl+ZZQoUyIpXaX1H1aAwTs5Z1+j/pF8aRj2DAADBYszg9y9sIHEc8z4M7rKsbSInY+w/y9nTNK1KYF5phXTxhgR512tCJStq/QUKPT1VXrX8v/qfeCB7OJiHNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaj8YjNh; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaj8YjNh"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4362507f0feso907009f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2026 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385150; x=1770989950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItjnUDBTrDRkRz4IDFBU65KXxTOZL40uI9DIWKAkmz0=;
        b=kaj8YjNhgQl7ezhxFzuYWM9LAFdYKtuOcZcT6d4wOtUsURwBE2eCkN+eCn7Ypfl3aW
         MU20x1sGa0KtuE8xdr7WrefRkuK7+OnBgs3XlK1CetGvoImT8fT9QBY8n1pNe7ZPsosi
         +rk/9p6ZSyvUiGTAqlhK5fKfh2cIbuC1F/JG1ZgS9yWrkqQ1mHUIkS7YENz9OQFrPTue
         Lm3oDAj+ocBMQcxKVcSaut4HrzOyyz9jplad9sLYnbANkslbiy1Zo/I1xtBrXAvKLmIA
         EOjInyNNCdfvXyBJ3iCFF37XhihVDlIjGUXXS+t1T5KuQshE1XLTqjwOiu0UGljchKdi
         vlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385150; x=1770989950;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItjnUDBTrDRkRz4IDFBU65KXxTOZL40uI9DIWKAkmz0=;
        b=ZvuLQOC9ALbV2K7/nlhQJoVz9h2vPi6tLiZ8iUJQwJY04QmZytU1HqnLZ+VzgXYOYG
         EWMwIOyC/zk29NwgwPdh7hpse1txCU2LfgW8OM8F8ROKdybKmaKNpfz5E+73wbzezlWa
         Kz3fT4ooHdXbNtp4QNfAOcAM+LcE//FUacYKZbmhP7pZSoANPjDngQ7eq594GsIh8WI8
         C4jv6/zlTsSuvZyYXeBw/HGD+s9gr9qgb1MRmXfXY0XQVG2jx5MAa609hFXrH8uY/CDt
         IvT4KgvDbbg8+tI1cz6Ipsf4lHWc3asnwMhNIQhkd2BsgF5Oo9yLgLYOwZNH/+zZcADs
         /41A==
X-Forwarded-Encrypted: i=1; AJvYcCXLZLk/9FW61C5tJf9rJGO7lHb61yN6Kuk1RWCFpjbkDmL26LJrotBybXRTczZ5jn3sPmpEFVUAhF5U@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmndUBryPS45TN9Gnw/5pczWAEtXfvK/v/XpN9WWidgz9j7G5
	0mc4NP8CjB+gqZ4ZnthyuSezgBFq92k3r52lBVrb2SHRZVQ89zAdfd/S8wFcAj4owrE=
X-Gm-Gg: AZuq6aJlA5Iss7/6KXt+vth3BZfC+CBSaZl7HjxDBkuGsSIswzNuQdHPiCavjOxrYT1
	KgZnOG7cvxfWup99FfaOOFBNEOi3ZaovH8UoYwLICi7KeVTbdVvbgwNa0evY0qFk6Rfk9wZU11h
	lzEn2dfkNRRmBC/PCX8VcTLXHSL4YnKZ4K/RllsH7MtZmbU77A+RnYLGBz0hp0GR8w48/oXCiDT
	ZfeAOjfIdwVB0xcMvS40BSbvzl+cNVLZo3wRjVbkeR5hSJ3kZk6BRfEudbjgXwTlCzEBgHQBEhn
	M6mDGBsAR8NKDLN4UNqNu0mjI99mhTiLfMKYgPAhL+uyyEtHoSfePgRiiVt75fPdSwKjufXx4c2
	n87RNplXXxAYVnYn26DYm8uA6x6bc5qjjxwUX83pWeSgRKXbxqrP+rW5GzZhrdQer+zmRaMK2Qf
	3TlVxFtm1SAN9egQoj
X-Received: by 2002:a05:6000:603:b0:436:1934:d234 with SMTP id ffacd0b85a97d-4362933cbe2mr4730033f8f.3.1770385150336;
        Fri, 06 Feb 2026 05:39:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm5892619f8f.13.2026.02.06.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:39:09 -0800 (PST)
Date: Fri, 6 Feb 2026 16:39:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] crush: remove forcefeed functionality
Message-ID: <aYXu-_GsMPJpbv8m@stanley.mountain>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Ceph Maintainers,

Commit 41ebcc0907c5 ("crush: remove forcefeed functionality") from
May 7, 2012 (linux-next), leads to the following Smatch static
checker warning:

	net/ceph/crush/mapper.c:1015 crush_do_rule()
	warn: iterator 'j' not incremented

net/ceph/crush/mapper.c
    897 int crush_do_rule(const struct crush_map *map,
    898                   int ruleno, int x, int *result, int result_max,
    899                   const __u32 *weight, int weight_max,
    900                   void *cwin, const struct crush_choose_arg *choose_args)
    901 {
    902         int result_len;
    903         struct crush_work *cw = cwin;
    904         int *a = cwin + map->working_size;
    905         int *b = a + result_max;
    906         int *c = b + result_max;
    907         int *w = a;
    908         int *o = b;
    909         int recurse_to_leaf;
    910         int wsize = 0;
    911         int osize;
    912         const struct crush_rule *rule;
    913         __u32 step;
    914         int i, j;
    915         int numrep;
    916         int out_size;
    917         /*
    918          * the original choose_total_tries value was off by one (it
    919          * counted "retries" and not "tries").  add one.
    920          */
    921         int choose_tries = map->choose_total_tries + 1;
    922         int choose_leaf_tries = 0;
    923         /*
    924          * the local tries values were counted as "retries", though,
    925          * and need no adjustment
    926          */
    927         int choose_local_retries = map->choose_local_tries;
    928         int choose_local_fallback_retries = map->choose_local_fallback_tries;
    929 
    930         int vary_r = map->chooseleaf_vary_r;
    931         int stable = map->chooseleaf_stable;
    932 
    933         if ((__u32)ruleno >= map->max_rules) {
    934                 dprintk(" bad ruleno %d\n", ruleno);
    935                 return 0;
    936         }
    937 
    938         rule = map->rules[ruleno];
    939         result_len = 0;
    940 
    941         for (step = 0; step < rule->len; step++) {
    942                 int firstn = 0;
    943                 const struct crush_rule_step *curstep = &rule->steps[step];
    944 
    945                 switch (curstep->op) {
    946                 case CRUSH_RULE_TAKE:
    947                         if ((curstep->arg1 >= 0 &&
    948                              curstep->arg1 < map->max_devices) ||
    949                             (-1-curstep->arg1 >= 0 &&
    950                              -1-curstep->arg1 < map->max_buckets &&
    951                              map->buckets[-1-curstep->arg1])) {
    952                                 w[0] = curstep->arg1;
    953                                 wsize = 1;
    954                         } else {
    955                                 dprintk(" bad take value %d\n", curstep->arg1);
    956                         }
    957                         break;
    958 
    959                 case CRUSH_RULE_SET_CHOOSE_TRIES:
    960                         if (curstep->arg1 > 0)
    961                                 choose_tries = curstep->arg1;
    962                         break;
    963 
    964                 case CRUSH_RULE_SET_CHOOSELEAF_TRIES:
    965                         if (curstep->arg1 > 0)
    966                                 choose_leaf_tries = curstep->arg1;
    967                         break;
    968 
    969                 case CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES:
    970                         if (curstep->arg1 >= 0)
    971                                 choose_local_retries = curstep->arg1;
    972                         break;
    973 
    974                 case CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES:
    975                         if (curstep->arg1 >= 0)
    976                                 choose_local_fallback_retries = curstep->arg1;
    977                         break;
    978 
    979                 case CRUSH_RULE_SET_CHOOSELEAF_VARY_R:
    980                         if (curstep->arg1 >= 0)
    981                                 vary_r = curstep->arg1;
    982                         break;
    983 
    984                 case CRUSH_RULE_SET_CHOOSELEAF_STABLE:
    985                         if (curstep->arg1 >= 0)
    986                                 stable = curstep->arg1;
    987                         break;
    988 
    989                 case CRUSH_RULE_CHOOSELEAF_FIRSTN:
    990                 case CRUSH_RULE_CHOOSE_FIRSTN:
    991                         firstn = 1;
    992                         fallthrough;
    993                 case CRUSH_RULE_CHOOSELEAF_INDEP:
    994                 case CRUSH_RULE_CHOOSE_INDEP:
    995                         if (wsize == 0)
    996                                 break;
    997 
    998                         recurse_to_leaf =
    999                                 curstep->op ==
    1000                                  CRUSH_RULE_CHOOSELEAF_FIRSTN ||
    1001                                 curstep->op ==
    1002                                 CRUSH_RULE_CHOOSELEAF_INDEP;
    1003 
    1004                         /* reset output */
    1005                         osize = 0;
    1006 
    1007                         for (i = 0; i < wsize; i++) {
    1008                                 int bno;
    1009                                 numrep = curstep->arg1;
    1010                                 if (numrep <= 0) {
    1011                                         numrep += result_max;
    1012                                         if (numrep <= 0)
    1013                                                 continue;
    1014                                 }
--> 1015                                 j = 0;
                                         ^^^^^

    1016                                 /* make sure bucket id is valid */
    1017                                 bno = -1 - w[i];
    1018                                 if (bno < 0 || bno >= map->max_buckets) {
    1019                                         /* w[i] is probably CRUSH_ITEM_NONE */
    1020                                         dprintk("  bad w[i] %d\n", w[i]);
    1021                                         continue;
    1022                                 }
    1023                                 if (firstn) {
    1024                                         int recurse_tries;
    1025                                         if (choose_leaf_tries)
    1026                                                 recurse_tries =
    1027                                                         choose_leaf_tries;
    1028                                         else if (map->chooseleaf_descend_once)
    1029                                                 recurse_tries = 1;
    1030                                         else
    1031                                                 recurse_tries = choose_tries;
    1032                                         osize += crush_choose_firstn(
    1033                                                 map,
    1034                                                 cw,
    1035                                                 map->buckets[bno],
    1036                                                 weight, weight_max,
    1037                                                 x, numrep,
    1038                                                 curstep->arg2,
    1039                                                 o+osize, j,
    1040                                                 result_max-osize,
    1041                                                 choose_tries,
    1042                                                 recurse_tries,
    1043                                                 choose_local_retries,
    1044                                                 choose_local_fallback_retries,
    1045                                                 recurse_to_leaf,
    1046                                                 vary_r,
    1047                                                 stable,
    1048                                                 c+osize,
    1049                                                 0,
    1050                                                 choose_args);
    1051                                 } else {
    1052                                         out_size = ((numrep < (result_max-osize)) ?
    1053                                                     numrep : (result_max-osize));
    1054                                         crush_choose_indep(
    1055                                                 map,
    1056                                                 cw,
    1057                                                 map->buckets[bno],
    1058                                                 weight, weight_max,
    1059                                                 x, out_size, numrep,
    1060                                                 curstep->arg2,
    1061                                                 o+osize, j,
    1062                                                 choose_tries,
    1063                                                 choose_leaf_tries ?
    1064                                                    choose_leaf_tries : 1,
    1065                                                 recurse_to_leaf,
    1066                                                 c+osize,
    1067                                                 0,
    1068                                                 choose_args);
    1069                                         osize += out_size;
    1070                                 }

There used to be a j++ around here but it was deleted.

    1071                         }
    1072 
    1073                         if (recurse_to_leaf)
    1074                                 /* copy final _leaf_ values to output set */
    1075                                 memcpy(o, c, osize*sizeof(*o));
    1076 
    1077                         /* swap o and w arrays */
    1078                         swap(o, w);
    1079                         wsize = osize;
    1080                         break;
    1081 
    1082 
    1083                 case CRUSH_RULE_EMIT:
    1084                         for (i = 0; i < wsize && result_len < result_max; i++) {
    1085                                 result[result_len] = w[i];
    1086                                 result_len++;
    1087                         }
    1088                         wsize = 0;
    1089                         break;
    1090 
    1091                 default:
    1092                         dprintk(" unknown op %d at step %d\n",
    1093                                 curstep->op, step);
    1094                         break;
    1095                 }
    1096         }
    1097 
    1098         return result_len;
    1099 }

regards,
dan carpenter
